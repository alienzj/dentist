/**
    This is the `processPileUps` command of `dentist`.

    Copyright: © 2018 Arne Ludwig <arne.ludwig@posteo.de>
    License: Subject to the terms of the MIT license, as written in the
             included LICENSE file.
    Authors: Arne Ludwig <arne.ludwig@posteo.de>
*/
module dentist.commands.processPileUps;

import dentist.commandline : OptionsFor;
import dentist.commands.processPileUps.cropper : CropOptions, cropPileUp;
import dentist.common :
    dentistEnforce,
    DentistException,
    id_t,
    ReferenceInterval,
    ReferencePoint,
    ReferenceRegion;
import dentist.common.alignments :
    AlignmentChain,
    AlignmentLocationSeed,
    getAlignmentRefs,
    getType,
    isExtension,
    isGap,
    makeJoin,
    PileUp,
    pileUpToSimpleJson,
    ReadAlignment,
    SeededAlignment;
import dentist.common.binio :
    CompressedSequence,
    InsertionDb,
    PileUpDb;
import dentist.common.commands : DentistCommand;
import dentist.common.insertions :
    Insertion,
    InsertionInfo;
import dentist.common.scaffold :
    ContigNode,
    getDefaultJoin,
    isParallel;
import dentist.util.log;
import dentist.dazzler :
    dbEmpty,
    dbSubset,
    getAlignments,
    getDalignment,
    getConsensus,
    getFastaSequence,
    readMask,
    writeMask;
import std.algorithm :
    canFind,
    countUntil,
    equal,
    filter,
    find,
    joiner,
    map,
    maxElement,
    merge,
    sort,
    uniq;
import std.array : array;
import std.conv : to;
import std.format : format;
import std.parallelism : parallel, taskPool;
import std.range : enumerate, evenChunks, only, zip;
import std.range.primitives : empty, front, popFront;
import std.typecons : Yes;
import vibe.data.json : toJson = serializeToJson;


/// Options for the `processPileUps` command.
alias Options = OptionsFor!(DentistCommand.processPileUps);

/// Execute the `processPileUps` command with `options`.
void execute(Options)(in Options options)
{
    auto processor = new PileUpsProcessor(options);

    processor.run();
}

/// This class comprises the `processPileUps` step of the `dentist` algorithm
class PileUpsProcessor
{
    protected const Options options;
    protected PileUp[] pileUps;
    ReferenceRegion repeatMask;
    Insertion[] insertions;

    this(in ref Options options)
    {
        this.options = options;
        this.insertions.length = options.pileUpBatchSize;
    }

    void run()
    {
        mixin(traceExecution);

        readPileUps();
        readRepeatMask();

        foreach (i, pileUp; parallel(pileUps))
            processPileUp(i, pileUp);

        insertions.sort();
        dropEmptyInsertions();
        writeInsertions();
    }

    protected void processPileUp(size_t i, PileUp pileUp)
    {
        auto processor = new PileUpProcessor(options, repeatMask);

        processor.run(i, pileUp, &insertions[i]);
    }

    protected void readPileUps()
    {
        mixin(traceExecution);

        auto pileUpDb = PileUpDb.parse(options.pileUpsFile);
        pileUps = pileUpDb[options.pileUpBatch[0] .. options.pileUpBatch[1]];
    }

    protected void readRepeatMask()
    {
        mixin(traceExecution);

        foreach (mask; options.repeatMasks)
            repeatMask |= ReferenceRegion(readMask!ReferenceInterval(
                options.refDb,
                mask,
                options.workdir,
            ));
    }

    protected void dropEmptyInsertions()
    {
        insertions = insertions.find!(ins => ins.start.contigId != 0);
    }

    protected void writeInsertions()
    {
        mixin(traceExecution);

        // Use this output to quickly generate test data
        debug if (shouldLog(LogLevel.debug_))
            printInsertions(insertions);

        InsertionDb.write(options.insertionsFile, insertions);
    }
}

/// This class processes a single pileup.
protected class PileUpProcessor
{
    const(Options) options;
    const(ReferenceRegion) repeatMask;

    protected size_t pileUpId;
    protected PileUp pileUp;
    protected Insertion* resultInsertion;
    protected string croppedDb;
    protected ReferencePoint[] croppingPositions;
    protected size_t referenceReadIdx;
    protected string consensusDb;
    protected AlignmentChain[] postConsensusAlignment;
    protected ReadAlignment insertionAlignment;
    protected CompressedSequence insertionSequence;
    protected Insertion insertion;

    this(in Options options, in ReferenceRegion repeatMask)
    {
        this.options = options;
        this.repeatMask = repeatMask;
    }

    void run(size_t pileUpId, PileUp pileUp, Insertion* resultInsertion)
    {
        mixin(traceExecution);

        this.pileUpId = options.pileUpBatch[0] + pileUpId;
        this.pileUp = pileUp;
        this.resultInsertion = resultInsertion;

        if (
            (!options.onlyFlags.extending && pileUp.isExtension) ||
            (!options.onlyFlags.spanning && pileUp.isGap)
        )
        {
            logJsonInfo(
                "info", "skipping pile up due to --only",
                "pileUpId", this.pileUpId,
                "pileUp", pileUp.pileUpToSimpleJson(),
            );

            return;
        }

        logJsonDiagnostic(
            "info", "processing pile up",
            "pileUpId", this.pileUpId,
            "pileUp", pileUp.pileUpToSimpleJson(),
        );

        processPileUp();
    }

    protected void processPileUp()
    {
        mixin(traceExecution);

        try
        {
            if (shouldSkipSmallPileUp())
                return;

            crop();
            selectReferenceRead();
            computeConsensus();
            alignConsensusToFlankingContigs();
            getInsertionAlignment();
            getInsertionSequence();

            *resultInsertion = makeInsertion();
        }
        catch(DentistException e)
        {
            logJsonWarn(
                "info", "skipping pile up due to errors",
                "reason", "error",
                "error", e.message.to!string,
                "errorPayload", e.payload,
                "pileUpId", pileUpId,
                "pileUp", pileUp.pileUpToSimpleJson,
            );
        }
        catch(Exception e)
        {
            logJsonWarn(
                "info", "skipping pile up due to errors",
                "reason", "error",
                "error", e.message.to!string,
                "pileUpId", pileUpId,
                "pileUp", pileUp.pileUpToSimpleJson,
            );
        }
    }

    protected bool shouldSkipSmallPileUp() const nothrow
    {
        if (pileUp.length < options.minReadsPerPileUp)
        {
            logJsonInfo(
                "info", "skipping pile up due to `minReadsPerPileUp`",
                "reason", "minReadsPerPileUp",
                "pileUpId", pileUpId,
                "pileUp", pileUp.pileUpToSimpleJson,
            );

            return true;
        }

        return false;
    }

    protected void crop()
    {
        auto croppingResult = cropPileUp(pileUp, repeatMask, CropOptions(
            options.readsDb,
            options.tracePointDistance,
            options.workdir,
        ));

        croppedDb = croppingResult.db;
        croppingPositions = croppingResult.referencePositions;
    }

    protected void selectReferenceRead()
    {
        referenceReadIdx = bestReadAlignmentIndex(pileUp, croppingPositions);

        logJsonDiagnostic("referenceReadIdx", referenceReadIdx);
        assert(referenceRead.length == croppingPositions.length);
    }

    protected @property inout(ReadAlignment) referenceRead() inout
    {
        return pileUp[referenceReadIdx];
    }

    protected size_t bestReadAlignmentIndex(
        in PileUp pileUp,
        in ReferencePoint[] referencePositions,
    ) const pure
    {
        // NOTE pileUp is not modified but the read alignments need to be assignable.
        return (cast(PileUp) pileUp)
            .enumerate
            .filter!(enumReadAlignment =>
                enumReadAlignment.value.length == referencePositions.length &&
                enumReadAlignment.value[].map!"a.contigA.id".equal(referencePositions.map!"a.contigId"))
            .maxElement!(enumReadAlignment => enumReadAlignment.value.meanScore)
            .index;
    }

    protected void computeConsensus()
    {
        mixin(traceExecution);

        consensusDb = getConsensus(
            croppedDb,
            referenceReadIdx + 1,
            options.consensusOptions,
        );

        dentistEnforce(
            !dbEmpty(consensusDb, options.workdir),
            "consensus could not be computed",
            [
                "consensusDb": consensusDb.toJson,
                "referenceRead": (referenceReadIdx + 1).toJson,
            ].toJson,
        );
    }

    protected void alignConsensusToFlankingContigs()
    {
        mixin(traceExecution);

        auto flankingContigIds = croppingPositions.map!"a.contigId".array;
        auto flankingContigsDb = dbSubset(
            options.refDb,
            flankingContigIds,
            options.consensusOptions,
        );
        auto flankingContigsRepeatMask = repeatMask
            .intervals
            .filter!(interval => flankingContigIds.canFind(interval.contigId))
            .map!(interval => ReferenceInterval(
                1 + flankingContigIds.countUntil(interval.contigId),
                interval.begin,
                interval.end,
            ))
            .array;
        writeMask(
            flankingContigsDb,
            options.flankingContigsRepeatMaskName,
            flankingContigsRepeatMask,
            options.workdir,
        );
        postConsensusAlignment = getAlignments(
            flankingContigsDb,
            consensusDb,
            getDalignment(
                flankingContigsDb,
                consensusDb,
                options.postConsensusAlignmentOptions,
                options.workdir,
            ),
            options.workdir,
            options.tracePointDistance,
        );

        foreach (ref ac; postConsensusAlignment)
        {
            // Insert correct `contigId`s
            ac.contigA.id = croppingPositions[ac.contigA.id - 1]
                .contigId
                .to!id_t;
            ac.disableIf(
                !ac.isProper(options.properAlignmentAllowance) ||
                ac.averageErrorRate >= options.maxInsertionsError
            );
        }

        dentistEnforce(
            postConsensusAlignment.canFind!"!a.flags.disabled",
            "consensus does not align to flanking contig(s)",
            ["consensusDb": consensusDb].toJson,
        );
    }

    protected void getInsertionAlignment()
    {
        mixin(traceExecution);

        SeededAlignment[2] insertionAlignmentBuffer;

        foreach (ref croppingPos; croppingPositions)
        {
            alias contigsMatch = ac => ac.contigA.id == croppingPos.contigId;

            auto refReadFlankAlignmentIdx = referenceRead[].countUntil!contigsMatch;
            assert(refReadFlankAlignmentIdx >= 0);
            auto alignmentSeed = referenceRead[refReadFlankAlignmentIdx].seed;

            alias isProperInsertionOverlap = ac =>
                alignmentSeed == AlignmentLocationSeed.front
                    ? ac.first.contigA.begin == 0 && ac.last.contigB.end == ac.contigB.length
                    : ac.last.contigA.end == ac.contigA.length && ac.first.contigB.begin == 0;

            auto flankAlignments = postConsensusAlignment
                .filter!(ac => !ac.flags.disabled)
                .filter!contigsMatch
                .filter!isProperInsertionOverlap;

            dentistEnforce(
                !flankAlignments.empty,
                format!"consensus does not align to flanking contig %d"(croppingPos.contigId),
                ["consensusDb": consensusDb].toJson,
            );

            auto flankAlignment = SeededAlignment(flankAlignments.front, alignmentSeed);
            insertionAlignmentBuffer[refReadFlankAlignmentIdx] = flankAlignment;

            flankAlignments.popFront();
            dentistEnforce(
                flankAlignments.empty,
                format!"consensus ambiguously aligns to flanking contig %d"(croppingPos.contigId),
                ["consensusDb": consensusDb].toJson,
            );
        }

        insertionAlignment = ReadAlignment(insertionAlignmentBuffer[0 .. referenceRead.length]);

        dentistEnforce(
            insertionAlignment.isValid,
            "consensus alignment is invalid",
            ["consensusDb": consensusDb].toJson,
        );
        dentistEnforce(
            (
                insertionAlignment.type == referenceRead.type &&
                insertionAlignment.isParallel == referenceRead.isParallel
            ),
            format!"consensus alignment has an unexpected type: %s%s"(
                insertionAlignment.type,
                insertionAlignment.isGap
                    ? insertionAlignment.isParallel
                        ? " (parallel)"
                        : " (anti-parallel)"
                    : "",
            ),
            ["consensusDb": consensusDb].toJson,
        );
    }

    protected void getInsertionSequence()
    {
        auto fastaSequence = getFastaSequence(consensusDb, 1, options.workdir);
        insertionSequence = CompressedSequence.from(fastaSequence);
    }

    protected Insertion makeInsertion()
    {
        auto insertion = makeJoin!Insertion(referenceRead);
        insertion.payload = InsertionInfo(
            insertionSequence,
            0,
            insertionAlignment[],
        );

        assert(insertion.isParallel == insertionAlignment.isParallel);

        return insertion;
    }
}

debug private void printInsertions(in Insertion[] insertions)
{
    import std.stdio : writefln;

    foreach (insertion; insertions)
    {
        writefln!"Insertion(";
        writefln!"    ContigNode(%d, %s),"(insertion.start.contigId, insertion.start.contigPart.to!string);
        writefln!"    ContigNode(%d, %s),"(insertion.end.contigId, insertion.end.contigPart.to!string);
        writefln!"    InsertionInfo(";
        writefln!`        CompressedSequence.from("%s"),`(insertion.payload.sequence.to!string);
        writefln!"        %d,"(insertion.payload.contigLength);
        writefln!"        [";

        foreach (overlap; insertion.payload.overlaps)
        {

        writefln!"            SeededAlignment(";
        writefln!"                AlignmentChain(";
        writefln!"                    %d,"(overlap.id);
        writefln!"                    Contig(%d, %d),"(overlap.contigA.id, overlap.contigA.length);
        writefln!"                    Contig(%d, %d),"(overlap.contigB.id, overlap.contigB.length);
        writefln!"                    %s,"(overlap.flags.complement ? "Flags(complement)" : "emptyFlags");
        writefln!"                    [";

        foreach (localAlignment; overlap.localAlignments)
        {
        writefln!"                        LocalAlignment(";
        writefln!"                            Locus(%d, %d),"(localAlignment.contigA.begin, localAlignment.contigA.end);
        writefln!"                            Locus(%d, %d),"(localAlignment.contigB.begin, localAlignment.contigB.end);
        writefln!"                            %d,"(localAlignment.numDiffs);
        writefln!"                            [";

        foreach (tracePoint; localAlignment.tracePoints)
        {
        writefln!"                                TracePoint(%d, %d),"(tracePoint.numDiffs, tracePoint.numBasePairs);
        }

        writefln!"                            ],";
        writefln!"                        ),";
        }

        writefln!"                    ],";
        writefln!"                    %d,"(overlap.tracePointDistance);
        writefln!"                ),";
        writefln!"                AlignmentLocationSeed.%s,"(overlap.seed.to!string);
        writefln!"            ),";

        }

        writefln!"        ],";
        writefln!"    ),";
        writefln!"),";
    }
}
