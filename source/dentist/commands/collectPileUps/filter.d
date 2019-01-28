/**
    This is a collection of helpers for the alignment filtering.

    Copyright: © 2018 Arne Ludwig <arne.ludwig@posteo.de>
    License: Subject to the terms of the MIT license, as written in the
             included LICENSE file.
    Authors: Arne Ludwig <arne.ludwig@posteo.de>
*/
module dentist.commands.collectPileUps.filter;

import dentist.common :
    ReadInterval,
    ReadRegion,
    ReferenceInterval,
    ReferenceRegion,
    to,
    toInterval;
import dentist.common.alignments :
    AlignmentChain,
    haveEqualIds;
import dentist.util.log;
import dentist.util.algorithm :
    cmpLexicographically,
    orderLexicographically;
import dentist.util.math :
    findMaximallyConnectedComponents,
    NaturalNumberSet;
import std.algorithm :
    all,
    chunkBy,
    copy,
    filter,
    isSorted,
    joiner,
    map,
    sort,
    uniq;
import std.array :
    appender,
    array;
import std.parallelism : taskPool;
import std.range :
    InputRange,
    inputRangeObject,
    walkLength;
import std.typecons : Flag, Yes;
import vibe.data.json : toJson = serializeToJson;

interface AlignmentChainFilter
{
    AlignmentChain[] opCall(AlignmentChain[] alignmentChains);
}

abstract class ReadFilter : AlignmentChainFilter
{
    NaturalNumberSet* unusedReads;

    this(NaturalNumberSet* unusedReads)
    {
        this.unusedReads = unusedReads;
    }

    override AlignmentChain[] opCall(AlignmentChain[] alignmentChains)
    {
        NaturalNumberSet discardedReadIds;
        discardedReadIds.reserveFor(unusedReads.capacity);

        foreach (discardedAlignment; getDiscardedReadIds(alignmentChains))
        {
            auto discardedReadId = discardedAlignment.contigB.id;

            discardedReadIds.add(discardedReadId);
            unusedReads.remove(discardedReadId);
        }

        foreach (ref alignmentChain; alignmentChains)
        {
            auto wasReadDiscarded = discardedReadIds.has(alignmentChain.contigB.id);
            alignmentChain.disableIf(wasReadDiscarded);
        }

        return alignmentChains;
    }

    InputRange!(AlignmentChain) getDiscardedReadIds(AlignmentChain[] alignmentChains);
}

/// Discard improper alignments.
class ImproperAlignmentChainsFilter : AlignmentChainFilter
{
    override AlignmentChain[] opCall(AlignmentChain[] alignmentChains)
    {
        foreach (ref alignmentChain; alignmentChains)
        {
            alignmentChain.disableIf(!alignmentChain.isProper);
        }

        return alignmentChains;
    }
}

/// Discard read if it has an alignment that – extended with the
/// exceeding read sequence on either end – is fully contained in
/// a single contig.
class RedundantAlignmentChainsFilter : ReadFilter
{
    this(NaturalNumberSet* unusedReads)
    {
        super(unusedReads);
    }

    override InputRange!(AlignmentChain) getDiscardedReadIds(AlignmentChain[] alignmentChains)
    {
        assert(alignmentChains.map!"a.isProper || a.flags.disabled".all);

        return inputRangeObject(alignmentChains.filter!"!a.flags.disabled && a.isFullyContained");
    }
}

alias orderByReadAndErrorRate = orderLexicographically!(
    AlignmentChain,
    ac => ac.contigB.id,
    ac => ac.averageErrorRate,
);

alias groupByRead = (lhs, rhs) => lhs.contigB.id == rhs.contigB.id;

/// Discard read if part of it aligns to multiple loci in the reference.
class AmbiguousAlignmentChainsFilter : AlignmentChainFilter
{
    NaturalNumberSet* unusedReads;

    this(NaturalNumberSet* unusedReads)
    {
        this.unusedReads = unusedReads;
    }

    override AlignmentChain[] opCall(AlignmentChain[] alignmentChains)
    {
        assert(alignmentChains.map!"a.isProper || a.flags.disabled".all);

        auto alignmentsGroupedByRead = alignmentChains
            .sort!orderByReadAndErrorRate
            .filter!"!a.flags.disabled"
            .chunkBy!groupByRead
            .map!array;
        auto bufferRest = taskPool
            .map!groupByReadLocus(alignmentsGroupedByRead)
            .map!(groupedByReadLocus => getUniquelyAlignedRead(groupedByReadLocus))
            .joiner
            .copy(alignmentChains);
        alignmentChains.length -= bufferRest.length;

        return alignmentChains;
    }

    /// Groups local alignments of one read into groups of overlapping alignments.
    static protected AlignmentChain[][] groupByReadLocus(AlignmentChain[] readAlignments)
    {
        assert(readAlignments.length > 0, "readAlignments chunk must not be empty");

        enum maximumExpectedGroups = 10;
        alias toReadInterval = toInterval!(ReadInterval, "contigB");
        alias getAlignmentIntervalAt = i => toReadInterval(readAlignments[i]);
        alias shareOverlap = (lhs, rhs) =>
            getAlignmentIntervalAt(lhs).intersects(getAlignmentIntervalAt(rhs));
        alias toGroup = (component) => component
            .elements
            .map!(i => readAlignments[i])
            .array;

        auto components = findMaximallyConnectedComponents!shareOverlap(readAlignments.length);
        auto groups = appender!(AlignmentChain[][]);

        groups.reserve(maximumExpectedGroups);
        groups.put(components.map!toGroup);

        return groups.data;
    }

    protected auto getUniquelyAlignedRead(AlignmentChain[][] groupedByReadLocus)
    {
        enum emptyRange = groupedByReadLocus.init.joiner;
        // bp/char in debug output
        enum blockSize = 250;

        foreach (ref readLocusAlignments; groupedByReadLocus)
        {
            if (readLocusAlignments.length > 1)
            {
                logJsonDiagnostic(
                    "info", "unable to resolve ambiguous read alignment",
                    "readId", readLocusAlignments[0].contigB.id,
                    "readLocusAlignments", shouldLog(LogLevel.debug_)
                        ? readLocusAlignments.toJson
                        : toJson(null),
                    "readLocusAlignmentIntervals", readLocusAlignments
                        .map!(toInterval!(ReadInterval, "contigB"))
                        .array
                        .toJson,
                    "alignmentCartoon", AlignmentChain.cartoon!"contigB"(
                        blockSize,
                        readLocusAlignments,
                    ),
                );

                this.unusedReads.remove(groupedByReadLocus[0][0].contigB.id);

                return emptyRange;
            }
        }

        return groupedByReadLocus.joiner;
    }

}

class WeaklyAnchoredAlignmentChainsFilter : AlignmentChainFilter
{
    size_t minAnchorLength;
    const(ReferenceRegion) repetitiveRegions;

    this(const(ReferenceRegion) repetitiveRegions, size_t minAnchorLength)
    {
        this.repetitiveRegions = repetitiveRegions;
        this.minAnchorLength = minAnchorLength;
    }

    AlignmentChain[] opCall(AlignmentChain[] alignmentChains)
    {
        foreach (ref alignmentChain; alignmentChains)
        {
            alignmentChain.disableIf(isWeaklyAnchored(alignmentChain));
        }

        return alignmentChains;
    }

    bool isWeaklyAnchored(AlignmentChain alignment)
    {
        // Mark reads as weakly anchored if they are mostly anchored in a
        // repetitive region
        auto uniqueAlignmentRegion = alignment.to!(ReferenceRegion, "contigA") - repetitiveRegions;
        bool isWeaklyAnchored = uniqueAlignmentRegion.size <= minAnchorLength;

        return isWeaklyAnchored;
    }
}
