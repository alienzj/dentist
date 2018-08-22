/**
    This package contains test data for the other packages in `dentist.common.binio`.

    Copyright: © 2018 Arne Ludwig <arne.ludwig@posteo.de>
    License: Subject to the terms of the MIT license, as written in the
             included LICENSE file.
    Authors: Arne Ludwig <arne.ludwig@posteo.de>
*/
module dentist.common.binio._testdata;

version (unittest)
{
    import dentist.common : ReferencePoint;
    import dentist.common.binio : CompressedSequence;
    import dentist.common.alignments :
        AlignmentChain,
        AlignmentLocationSeed,
        PileUp,
        ReadAlignment,
        SeededAlignment;
    import dentist.common.insertions :
        Insertion,
        InsertionInfo,
        SpliceSite;
    import dentist.common.scaffold :
        ContigNode,
        ContigPart;


    enum numInsertions = 12;
    enum numCompressedBaseQuads = 6247;
    enum numSpliceSites = 14;

    Insertion[] getInsertionsTestData()
    {
        with (AlignmentChain) with (Flag) with (ContigPart)
            return [
                Insertion(
                    ContigNode(1, begin),
                    ContigNode(1, end),
                    InsertionInfo(
                        CompressedSequence.from(""),
                        0,
                        [
                            SpliceSite(
                                ReferencePoint(1, 200),
                                emptyFlags,
                            ),
                        ]
                    ),
                ),
                Insertion(
                    ContigNode(1, begin),
                    ContigNode(1, end),
                    InsertionInfo(
                        CompressedSequence.from(""),
                        0,
                        [
                            SpliceSite(
                                ReferencePoint(1, 700),
                                emptyFlags,
                            ),
                        ]
                    ),
                ),
                Insertion(
                    ContigNode(1, begin),
                    ContigNode(206, end),
                    InsertionInfo(
                        CompressedSequence.from("gtttcgggattaaactgacagatcctcggttaccaagctaggttgcacccagaaactgtagaagttttatacacggccgtaatgaggtcagaacagtggcacctagctggcctactccaaattggttagctcactccagatacttcggctggtactacttaagagattcggcgcattccatatgcacgttagacaagtagcgtcagagcgcgcctccctgacgagttccttgtgaccgcgtaagcaagtggtgtctgctaactttcccccacattggacgcgccaacccagaccgcttgcgtgaggactagcccctaacaaccggagaagcatgcgttagcgttatttagactccgtcctgtgcgattctactcaacgggatctcggctccgcaattttccgcataaaatgcaagcttccaacctgtgtcgtgtgggtcgagcagtaagggtttaaagtaactagccttcaacgatagaccattctgaggtccggtcaatcccgccaccgcgtgcatgagagcgggccctgctagcctaagagcctgataaggaaataagttcgacgaaacttgaggactgcatccaaacgccggcataccattaatggggtaattatatccggggtagttggtcctccgaactctacagatcgtggccccaggtaccgctcgacacttaccggtcctttaggttggtcagtccccggctccacacagaacgtaatgacatggcatattgcaagtcctcttttcaacaagacagtaccagctccgggataatgtagagaggttttggtcgctaattaaccttgagagttagatcgtaaagcgtcatttctgtaaaaccggctggtatgacctgtgtttctagggtcgaccgagattcgagtatcgcccagccagctaatgacgcgcccatagaacgtatcgtggtccgcggtccctctgcagttggtgccgactataaaggaccagatccccttcacgtcgcgctttctcggcatactgattctggtcttagaagcgaacatgggctttccacccctcgagtttgaaccgacgctgataagattgatcagaaccgattttttaaagttatagcgcctgcgaattatccataggctgtcgtgggcctgtgctacccccccccctttcagaacatccagtatcctcgcgctatagtatttacgagtcgtcaagggtgttttagctagtgcgaccaatgttaggcacctactcctttgattgttttgcgagtgtgagacttcatagggtccatagtgctaacgaaaaagcaatgcgccgtcgtccgtcatcacgacacctatcatggcaatagggttgccacgttataaatatgcttagtgagatcgttcgaccggtgagtgtaactataactgctcacaaagctgtaaggattggcatcacatcgaggcctgaatttaattcataaccctaccgtatctagtcttggttgttcggtgaatcccccggcagaccacgggtcgttctgggctctctattcccaccttccctcttggaatcttcattagacaacgactcatagcgttttcggattgctggcctcttcttgcctctatagatgcagagggaccttacgatcgcagcttcgaggattaccgaggggcacccctacaatcctcgacgcagccgctccagagccaacacagagtagcacttcaggtacagcctgtgctttatatcgtaccccacgccgtgaagatcatatggtctcataataagtgtccgggacgacaatacattgattgatgcggagggacctaatccgtctacttccgatctgggagagtaagtagacacccactcagacacctcctctgggaggctcgagattccttagcggcgagggctttgtccaggcctaatttttgataagtatcgagcactcacatggggccacaatacgcaataattgttacgtctttgtctccgcactctgaaaacacgaaactactgtagatctcgccctacaggttgcctgaagagaattccccgaatccctacatgaatcggtatattcttaagatatacggctcttcgtgactatagccaactggcaatgtttttctgccaaaaggttgcgggggtcggttagacttaaacccactgacttaggatcatattgctcagttcggcttaactcctgcagtccggataatttagcagtgaatcggtcattcagagccgaattaaaatgaagtccgaccggcaacctgttaaacaagattgtgactttacgaaccacatccgctccgctaaagtgtttagctcgtctcttgccacgactgggtttgaagtatcgcatgcataacctccgtgtgaatgcacatgcgactcctagtcttatataaggtaggccacgttttctgcggcggaacagagaggcgacacctacatcagtaaaatc"),
                        0,
                        [
                            SpliceSite(
                                ReferencePoint(1, 200),
                                Flags(complement),
                            ),
                            SpliceSite(
                                ReferencePoint(206, 3900),
                                Flags(complement),
                            ),
                        ]
                    ),
                ),
                Insertion(
                    ContigNode(1, end),
                    ContigNode(110, begin),
                    InsertionInfo(
                        CompressedSequence.from("gaccacccacgcacagacaagtgtattcgaagcttagtggccctgtaggtggtcctcgtgcaatgttaggaccaagtgcaatttatctgtattaagtgactttcaggtaagtgccaatcgcggcacacggagtggctaccatatcagttcatcgttacacgaccgacgtttgctacgggcggaaggtggtaatcagcatatagacagctagatagaatgttacacacacaaacactgggcataatgtatgctttcgaagggagcgacggtccgttaatttttgcgctagggagtattagacgttgaacactgttacaggcgcatcacgcctaagccaggcacttccctcttctgataagggcccttgtcgcataagtggcgctcaaaaacgcgaaatgacgatcgcctacgcgcacttgaccaaaaagaattatgacttgacggtatctgtaatgtcctgaccacctgtttaacaggtggtcgcaccgagaggaaggtgcgaggaggctctcttggggaatccaacagatcacacgtgggttctggatacatagacttcgggagttctttcctacctaccgcaccgacctgtggcggacacacccgccgcaatcgctgtgacacccacgcagttcgacaatcttagaacagccgctataacactttgggtaagatgttggagtcaggacaagtacgtatgcgtaaaacaatgtggcccgagtattgctagttcgaccgtgtatggttggatcagagactgtcgtgtgaacctcacgccagttcccaaactgcccgtcggagtttgctgagtaatgttggtgatcgatggttatcatgtgtcttcgtacggagaagatctccttatcgaaatcggtcagactaattaagtagcatagtgtgctaaattggaactaggcgacgggggctgctgtgcgcggttcttttcgactcctccgtcagtatgtctacacacgatgtcttctgatactcctcatacatagagacttttcgaggtcgcaactcgcgggtgcagtggacacctctaaaggcgtccacagtcatgtgccgaggagtggaaattcactcgcacactgcagcat"),
                        0,
                        [
                            SpliceSite(
                                ReferencePoint(1, 700),
                                emptyFlags,
                            ),
                            SpliceSite(
                                ReferencePoint(110, 200),
                                emptyFlags,
                            ),
                        ]
                    ),
                ),
                Insertion(
                    ContigNode(4, begin),
                    ContigNode(4, end),
                    InsertionInfo(
                        CompressedSequence.from(""),
                        0,
                        [
                            SpliceSite(
                                ReferencePoint(4, 3300),
                                emptyFlags,
                            ),
                        ]
                    ),
                ),
                Insertion(
                    ContigNode(4, begin),
                    ContigNode(4, end),
                    InsertionInfo(
                        CompressedSequence.from(""),
                        0,
                        [
                            SpliceSite(
                                ReferencePoint(4, 3400),
                                emptyFlags,
                            ),
                        ]
                    ),
                ),
                Insertion(
                    ContigNode(4, end),
                    ContigNode(4, post),
                    InsertionInfo(
                        CompressedSequence.from("gtattcattatgggtacatgtcaacagcttaagatttaataccggagggcgaattcaatcccagcgctgtaaagagtaactggcgtgacatttatggacaattagactagcagcggatcttcatgatcacccccaagttgggacacacgcggggcgacgaagagttataattgaagcgtggcgatacacggtgtatctcgggtgtctttcgtagaccagcctgttaacttcacgagagtttgtccggcatcgcttgcggatcgggacgttcgttagttcgattaacgcgtgaactgccggttaaaggactatagatcggcgagagctttcttgtacgggtaacagtcgtttttactactcttggctcgactgttcttctgacactttagttgcaatgctacaagccaggatacgcatgtgggtaaacgtacatgattcggttcgagatattaatatgcatcccgatacgttttctgggactcgaatcggagactagtgttccgagaggaatcaaactaagatggagggggatacgagtaacggaccgtcctcggaatgtcgtctttaagatacttgcaaagacaagggacaaattcgccagttgttccttgcgaaggcgcatgtgaggcgtatacagggtcggcagtcagcaacacggctgaccctgggtcatcgactccacctcggttttaagagcacgttaacccccaggcacattttttggagtgtttcaagcggtgtgttggcccccaggcggggcggcactgcaggatcggggttaatagtgaccgagtgtcaggttctggggattgcaggataaaccgcgtctcatctgaacctgtctgttcaggttccaacccgtaaaactaggttactctaccgttgaaaggtggtactgccgagtgagacgcatactagcttgcaagtgatcggatccgggattacaacaaagccgcggggagtaaccacggcgagtgtagggacccagcgatacaccgcaaagccgaagtaactatttacggcaatcccctatgacttcgtagttagggggtccatgacgacaaagtatgcgagaggacccgggttttccttgttggccttcaaattcctccagtaatacatggagaatacgcgcactgaggagaccgcatcattgaccacgacggctggatttgtacccgtccgttccgaatatcctgcggtcccctcgacataattaaaccgccgttctcgttacagtagttctggaatagacccttctggcggtaggaaggctgtgaactaggcgaatatgccgcatgcatacacacgatgggtgttctagttgtccctgcattttagcatgctgtccccaactattgtctccgctcaattgtgtatcatgcaaacgaattctctacattaatgtagaaaatggagtattcacagttacagcgcatgcgatgccaggtctcaacgcgatccagcttttataactaagatctcgtttccgatcataatttcttaggtgtggggtgttccctcagcctgtccctagattcgcgagtgctttcggcgcctcccctggctaataaccgtctagataaagaactattagggggagacctaaatggtgcattcccaaaagtggtgcgcattgtacacaccatcggccagcatgctagaagcatgcctatcacttcccgcatcggtcctagagcacaaacatttagggcaactgatcgagatctccataacagcatcaacctacccccccatagccggagaactcgcaactagtaagttagtctaacctcaatctgtgcgagagtattcaagaagagtccgtgatttttacatgcttttctggacggtgtggcttaaacgctgggcatgttactctatcttgcctcatccaccggcgtggttccaaaaaccagggaagaatccgattgtaggagccaacggcaccgccggtacccctttatgaaaagggtgattcagcaccgctcgatccctacggtcagtttttcgtcgtgactgttggattctgtttgaacgtatagagccagtgtccacacgccggatcgttcacattatcggttgcgaaattatagacagggccacctgacttacctcagatgctcctcgattcaacaacgggtagcattcgtctggtggcctctcgccaggcaacagcttgtcgagcaggaaagggacgctagaacgattgaccgcggtccgttgcaatttaatgcgccatcagcgcgagggcctaattttatgcagaggacttagcgagatccattaagggaagttctgccgcacggatgaaaagggacagaactcaaattcctatacggtcgcaaaagcatagtgccttcggccgggctccatcatcaaaacgtacatttagcaacacatcaactacacatcggctcttctttactcaacggcgaattatatttcgcgcggcgctctgccagattagtggctgcagtcaggtggttagaggagtgaataatacagtggtatgaatgcttaacccattcattagatcgcgaactgggatatattggccccaccgcttgtacagatcaggcgcttaggattgttttttatacggctacatccctggaaccgtaaggttctacggcagtcagttttagcccggctggtacagtgcctcgctttaatagatctactgcctgtgcgaacgtagggttgcagagacattgctcttagattaaaatggacgtggctttgcgagtctagggcgccaaaatatacagggctttatgcttaccaggcaccctacaagtaagtctagtgcgaaataccgaccgggttcattctaatcatgaactgcacgtccacgaagaatgcacaggcgtgtgccaggtacattggctcggtcgggtaaaccaagaaattgagttaatattatgtccgtctggaagcggatgatcccgcgacaggcttcgactcgcgtggacttcatttcgcacccttattgtgcgctggcgagttgcctctctcgaataaccgttcaagacaccgtaatataactgtgttggcatgtccagaccaacagtggtaatctaggcgatctgcatattagctggctgaagtgcgctgtcgactgacctggcaggctgtcgcctgcatcagtgcagtagacataagttaacttaactttgcggcgtagcggtgttagtcggcccgaagacccctctaacaattagagtttgttatcgcatcggttttaaatgaactgctcgagtagagagtttacgccataggtcgattttgtgttgcagcgtatttccgctcatagcgagtcaaggcaaaaaaatacgcgctatgatcatgatgccaacctactacggatgtattacgtaggccggtcctatcattgacaaaaggggacaacaacacgactccaaagtcccaaatctacatcgtgcgtaggtgtattacatctcacgatagtcttcgcccttaaccacaagctttccgctaagtcgcctgcggcctattaactttaaacgatcgctaagggactcttgactcttacataccaagcgcggccccagatccccttagccctcttgtatgttttgcctctgaccaagtgaaacgaacagttccgagtacccttctcttttgatcaaatatctgccttaggatccgccacatgggtcgacaaccaagtaaggttgagagcctttactcggctctagtaagatctctccagtctttcagcgagggttgatgagccgacgacagccctgttcgtatcgcgaggccagtggtcagagttgcccgctcgctagacgtcgtgcatgataatcgtgtttcatcctcaattctccgtgcagggagaaccttcaaggcgaaggaacaagaagtaggctatcgtgcgccgttcacagtacccactacaccctacgtatgtactagtagcgatagtaaatggcttcgtccaggcttcgcattcagttatctagcggaggctggtagtcctcttcgtagatagacagccgggtgttggtttgtgggggaacacgcgacctagggggtgccctcctctcgtgtcatttgcgggtagaagctagtccccgatggtaa"),
                        0,
                        [
                            SpliceSite(
                                ReferencePoint(4, 3400),
                                Flags(complement),
                            ),
                        ]
                    ),
                ),
                Insertion(
                    ContigNode(4, pre),
                    ContigNode(4, begin),
                    InsertionInfo(
                        CompressedSequence.from("agaagtgtgcagcacgttcttacaatcagcgatcacgccggtatatctccttcaccacgtactctagagaccgttctaaaacatcttatcgtttaatataccaggggatatcaaacctcctgtcccgtttctcctgcaggttgccgccagatattcaggtcaagcgtgctgcagccccactaccagggcatccgaggacagagaaacgccgatttacaaaagtgtcgtaccctggttctgggggctcctgaatcagattctacgtttcatcacgattctttcaacgtcggaggatacggttgaccccggatttacaacaagcctttagtacacccccaacgaaggggttcaacctaacgtcgattgatgccttgtaagagaatatatgtttatacgttcgatgaacgaccggacgctcagactggattttgcgacacagcggccacgttacgttccgggtctatatcacggtcggacttaaatctgcaaatagctgtatactctacgaagttgtcttcggctcgcctcaacgacgtcctctggtaccatatgatgatacacttcgcaacgaaagagcgatttccggtgcacgcggcaactagacagcgcttcgaattcgaatatgatttcaggcgaatcgttctcggggggacacgagggtcagtgccaggcttgttccgtcccgcgctctggccgagcccgttccccaattaccatcggcaatgcggcgctctcctcctcaataacgacagcattttcgaacactttctattccaatgcgctgactcagtgtaggagcttcgcgtcggccgaccagatagagattaattgggactgtaacctactatctgatggacaaacataagaggcgacttcctctccctaaattgagcggtacggcgagatgcttgatcgttagtatgtgagtctgttctgctcctcagtgtattgtatgacttctggattatacaccatttaccacggcgtggttgtttataacgagggggggatacgggggttcttaacaagaaggcaatcagggtgctctatctgaggtccggggtctgtgtttcgtaaatgctcgattggtaaggatccgtcgcctgtcgagggatgttgaatgttaaagtcgtatattatttaccaattggccaaagtttcctacaactgcgatccattgatctggcagccgttacgttagcactccgaaaaatgtgtaatcggaccgagccggcacatgcgatataaggcatctccgaggttttgcgggtatcggggaactccatgacggtctattgagtcagccgatccagaacccatctcccgtgttgtgaagggaacacatcctatctagtgcaaccatgttctaaccgctccatccgtgtacttcccacagggtcgtgggccgtagacaagttctgaatgcggggatgcggccctcatttagtcctgctatgggcattatttcactctggatcgatgagctccaccgcgacagcgatatcggagcttgcttgaacggtcactcttcggcaaaagagtcgtgcaagttacggcgagtgcacccgcgagccatcctgaagaaccaaacactggctgacataatactaccttgcagagatgggctacgcaccgactaagatggagctagagcctattctacaacctcgttgctcggcgttgcctcacgctcaacagcaaagatataacgcgaaaagaacaacacgtagtttttaatacatgtaacatcaattcgttgccggtaagctcctcacctaccaaccgcaagacagggtagaggcggtttctacgtacattcgtaagtgtcaaggtacccgacgctccctatagcgagtccccctgcatttctctgcttgtcgaatatttacatccaccttacgctctaaaatccatcgttgagtccgggcgagaccaagcggccctcaatccaatagaacgaagcttggaaaatttgaactcattagacgcactccacattgctatcctggagggtactgcccgcagcccatggcatatttttctcagatcctctgtaggaggtggcccctcaggagacggaaattcctctggtaatagttaaattatagttactgcaaggcttctgcccagagtccctgccagacaacgctggtgccgtgttgcagttcgggagtggatcctgcaccccgcgtgatagccattttggacggactgtgagtgtcgttctcgactttttgcgtacctagttgatggcagggcatcaaataagtctcttctgttacaaaacctccttagcttggggcgtctctgcgcatactacgaagccccatgacaatagatttttttcccttgtttaagcggccgaaagaggtacgctggcgttatattagtctttgtaatagtgccactgactgatcacgatgtgtttggaaccatcactttgaggatgcacggacgacaggcgggattatcactctccaaatcgggaagcaaacgcactcgtacggccgtaagatgtaagtactgaagtgcatctcacctgcaggattttctccaatatggcgattatgggttcccccttaattaagggaggtgcctaccaaatgcctaagtgtcttaagttcagcgctatctcgacccaatcgtttgggagtgtttcccgtttgggctggatattatactccaactgtttgtggtagtggactccgcctctcagatcctcgtgaatacacctgtatcaacaagtagattatgatgacgctgcggacgaacctgcctgttgaagtatgtttacacgccagaacacatacatttgctgccaatccctggttgggttagcccccagattacggcgaatgaatagaatctgtctgcatctcaaaatttcgacgtgtcaccacctttgctctatgaacttgcgatctcgaaagcaataaagagtggtccggtgagggaatctcttgcaaactacggcgtcggcagtaggctagattccccagcattgcacgctctaaactcggctaacgtttggtcagtaacatcaatcaacgtcgtagagaccgcatggcttcaaaagggagcggacgtcaatagttcgacgacgttttatctacccacataccatgagttcggcggaatataagtattcgtaattcggagtcagttcatgctgacaaaatccgcaagcgaaatatcctacgtagctgtagggtaagccgagtgaacaggctacaggctcagttgaacgctgggtagcaacgacatagctctagccgtgcgcaacctgacccgctctggtcagtccgggggtgcgtcttgcgcggatacatgtgtgcggggtagtacagtcatcaatgtaggctccctcgatattaaaatgacaatgtgggatgaataagtggtgcgcctgtgagccacgtggcggagggagtacgacgtgctcaggagggtagccgcaatttaaatcgaactataggttgtgatacagctgatccgtcgatccctggagctgataatagtaccctgctaaagatcaccctcccgcttattgcggctttcccaaagagttcagacgccaatagaagcaatttccgaactatcctgctacattcaccgggcttgtgagtgttcgcatgcattcagtttttcgaaacgacatgtcatcctaccgtttttattgtcggcgatgtgataccaacacatgacgcctactccacgtcgcgggcggcgggcggtggcatttaatctgtaaacgtttacatcaagcgccccgttaagccatcgctcttctgtcaatgatccgaacatcgtgaagtcctgtattccggctatgaatccgcggaatgtagtgcggggcttgaataacgaagactagtcaggtcttacgtcacgactagctagagtaagacgactcatctctttgtcatacaagcataagtgcaatcctattagatccatctacaagaaaaactggcggtccatgatacgactgtggcggtagggcatgactgagggcgagactccgaacaggatattcccacgcctagcctggctcgtggctgttgttaccgcaagagaggatctcatcgatggttcgtgtagttgtacgtgacggggtatagcaaccagccacggggcggacacgggtttttaccgcaaagggtaattgatactagcgaggattagagctgccaactggcttagtgcgcgtgggggacgccttcaggggttggtgataggcagaggtcttggtgtaaactgttctaatgtgtatcggcaaacaactactgcgatcggggatgagattagtgcgccggatcggtttccggcactacgattccaaacacgacgacaaccaatagtatctggttgatgacaaatcttatgttggggtctacgtgcgaggggtcgaggtgcattatagattgctttatattacaacaaaatttcactcacgctatgaaccctgaagcaccgctagtgtttccgggattggtttatatcccctgaatcgaataacgaggaccaagcaagtgaggggtacctggctatatcagctaatatcaagggtaggataggtcccagagtaaaggactactagtacttcgccccgttccggcgagcataccgatgagggggcgtatgagtgatcctcacgcagttttatgatacactatggtacgctaccgggagttttactgtcaccgtgcgtcacccttatctcgtacccttgcccaggctggctgacagaaaattttaggagcaagagagatatgcggttttcacttagtatggtataggagacttacaataggaggtcagattatatgacgacgaaacagggaggtgtgcgaccatcaaaactttaccgaattcctaatacaaggtgtcggtgaccgtgagccactccttcgctcgcatggcgctgcagaacgtggattacattaccacgagagcgacatcccttctcatgatggtgccttgccttgaatgcctgtgggtagccgcgcactctcctacggagcgtatataggcgagacgttgtggcgaccgcatggatgaggaacgccgctagagcagagctagcccgtcgatcaacagcacgctctcgacgagttagcaatcagagctacacagattcaggcgcgcatagtattacatcccaactccgaaaccaaaataggtcccgattcattcgagagactaaacactcaatgaattcttaactatgtcaggactagcgctcataatgacgatctgattggttgaatcccttcttaaaattaactagctgtttctgcgacaccggatctacgattcctgcctcggacccttgagtggtacaattacacccgagggaggggtccgcttacgtcatacgagactccccctgggcactgctcgtcctcaccacggcatgagattgtccttgtaccatgaattcgttaatcgtaaacatcactgttttccactcaattgccgcgctgtaggagacgcggagtcttatgaggagaaaagaatatgtaagtaagacatttatcacctaggatgcagcgggtttaactacgcctcagtccagcgcgacgacatggaaacattctgttgtaaggggtacacttcggaagtctaagtcggtcgaactgcggtctaaatcccctgggctaaatccgggatgactggtgccccagtgaagcctcggaactactcaatcttgcatctgctactcgtctgacacatcagaagacgctctcttcttaggacctcactatcagtaagcagatattaaaatgaccggcctaacgccgaaaatatctgtaaagaccccaggccgccgggccttttaggcgtgtcatggcaaggtctagcagcagtttgcgagtacagaggaagactccgacgctggtagtccacctacgccgttgctcgtagccgcagccgaaagctgtgccgcccttctctaccgatttgaacgctgggcaatagctgccaccgttgttatatacggtcacgacgctacagtgcgactgtcgttttgtcgagtacaacttgctggtagaactactgctcacgccgctgcggacaagaaacctgaaattcggagtacagtcatgcaggtgaccgcttccttaacgtaagcaatatttccttaaacggttccctggcaggaaaatggggaaagaaacctatcacgtgcctagcgaccgaatcaccttgtgcctccttgcgcggtgtgagcgatggacgcatccgatccggcgtgatgctccaatatgagccgttccgtctgggaaacctcggcagaaccacggccaagattggcttagttgtacccataatcactcagtgcggccagtcccgataagaccctttgggctttcagtcattcgaatagcccgttcgtgcacgaatgagtcttgattaccatatagttatgaataaaagtaggactagtctctttcacagtataggggagacggcgccgaaccacccggttccggactacatagtccatgacataaatcgacctcgctagcaccgaggacaagttagcgagtcacctgcttggttgtagatgggaattataaactaacccgttggggggccaagccacgctctgaggtacgaacaggtttcagatatgaaaaggactccgttcctcgtcagcggctttgtaagagacacattagtcctgctgctccagaccataactccaccattgttgtgacgacgtgcgagggtttgatgtagaatacgacgtatcgtttctgagtggtatacggctgcaaccgggaaaaccttggatgaattcctgccgctatatcgatattaaactccgcgaccattacttccccgacgacgggcagccggttctgtttcataatgaggtcttaccactggtctttcggggctacagggccctacgcaatatgttatctctagcagcttgtggcgccgttctctcgataatcgttcgcgcggtcatagacaaaacgtacaatgcccggctgtgtttaacaatttaccccctggttttgcggctcagtacttgctacacactagttattgggatggaccacggagtgtcaacgtaattgatgaagtataggatccacatccgccgacggctacaattcgtgtaattacttttagggcttttctctggcgatttcgggacacatcacagcgcatacgcgtgccaggcgaaagagaatcatgaaagagcctacttttcaactcaggtaacataataagaggcgttaaagcgtacagtacggtagataagacggataatgtcgcctcatataattagcgtcttcgtaaccttcaacgaacgtcctactggcgcttcactcgagacgcttgactaagcacacggcgtggggacccatcgtcgaggaccgtggccaacggagttcgcgcaacatgtccgcaaagacctgtgcaattgtctcagaaggaccggagctggatccttgcgatcatccctgacaatctcaaaacttttaaaccttatgttgaagtctgctctgatagttagtatccagaggttttgaggtgagctcaacgcgaatcttcttcgtttgcgaggactcgccgtaccaatatggggacgctccacacggagtattccgcaatgcagttgggactttaaaaaaattgatcgtgcgctcgccattcagatcgcgcacaaaatagaaaggggtcctcgttgggcggaacggctcgagtcagtcaaaacgattactgctgaacgccccgcgtagcgcaaaccagtaggagccctaggcctgatttaggaagctcgttggaagaatgcacagtgccatcctttgatccatcgatgacccgagcgtatgtaaggaatcgcgcacaagctaagagagctgtcgtccgtgaggaaaatagggcgatgcgcgggcttatctagctggtggatagccactcccagcaaaagtcaaaactgacagcgtccaaagggttaatgcaaagttaaaggagcatctggtccgttcagatccgcgggctctattatgcatatacatggccagtgggatcagtcataggaggccgttatattgtcaaacagtcaatcttttgtcttccgactactcaaaactcgtaattttttcaacaggctcgctgggctgtctccgtccgtctaccttgcccgagcacgagccgtgaccgcctgactgtgcagtatgcccaggactcgtgttacgcttcgtcctaaatcaatcagcctctgttgctcgcagtccaaggggcctggaggtccgtaataataactacagccgctgtgtatccgccgttgcatacgctgaacagggccacgtaaccatgtgttgtaatgtgcaac"),
                        0,
                        [
                            SpliceSite(
                                ReferencePoint(4, 3300),
                                emptyFlags,
                            ),
                        ]
                    ),
                ),
                Insertion(
                    ContigNode(5, begin),
                    ContigNode(5, end),
                    InsertionInfo(
                        CompressedSequence.from(""),
                        0,
                        [
                            SpliceSite(
                                ReferencePoint(5, 2600),
                                emptyFlags,
                            ),
                        ]
                    ),
                ),
                Insertion(
                    ContigNode(5, begin),
                    ContigNode(5, end),
                    InsertionInfo(
                        CompressedSequence.from(""),
                        0,
                        [
                            SpliceSite(
                                ReferencePoint(5, 2700),
                                emptyFlags,
                            ),
                        ]
                    ),
                ),
                Insertion(
                    ContigNode(5, end),
                    ContigNode(5, post),
                    InsertionInfo(
                        CompressedSequence.from("ccacccaagctggatgtctcctccgcggctggcgttatgagtgtagtctagtaatgtccggtgactatgagcggttttgtatgtgggagcgtgatccaagttagaaaatcctagaatctattaatagcgaagaacaaagttttggcctaacacctagatgcctcaggtaacctcggatagggggatggataaccgcaactgacacgtggaggcagctctgcacgcaacccactgtcccgattaccggctctatattcttcactctgagtccttattatttggccgaatgttctgcaacgaatttgtcactgcagtgatagggagttggacccacactatgcatctgggaaggtaaaagtacatcgtccttttattcgatggccccggttgaaagcactagccatctgccggaaatagtgggcacatcagcgctgatcttatagatcctttcacacgacgtctctcgttctggttatcgttcccatttctgcgtacaagtagtttacgtcctctaattgaatgagttaccatctacaagagagttttacgctagtcacagcaaacgaacgacggaggacatttttcacagagtctcaccacgaaacccctaaaacaaccgaggtaccgttgtacgcttcaattcgttacaagtcactgatataaggagtgtgcttatctcgggctttgtcgctatgacaccaagatggttttcatcgtgatataaatcgaccttccgccctatgggggttttgccattagacaaaggacacaccagcagatagcgcattttaataaagaagatggaacccgaaacatgcggcaggaattggcgttttgacccctatcctcacttcgtccggagcccagattgaccgcgcgtgatgcagcgtcagtactggcggctaccgcctgaaggcctgtggacatctactatagaagatactccaacatgtctcgactggaatcaaggtcgcggctttaatacgctccgcttaaattaatcaagcccagagattgccgcagtgagtatctgagtaataacggattgagactaccaataccacgcaactctcagcgacagtgagacattgattcctgagaccgagaggacaacggcgaccgtgctataccgcccatcattaataaaccttttaccgcctattcctaaaccgactatgattctactatggaaagagaatatctccttggacacgaccttgatgagtccaccgcggacccgcttgcgaagggcatttggataggacatcataggcgacattcctggcacatgtcggctgttggactagcagtaaggttcacgcgctttggctgtggccattaaataggtacccgttacagtgcctcggactagccagttaaaattgctctcattagcgatgtcatggatttacgagaaacagccttcgtcactgtcgaaaggcaagagtgcttcacggcaacttgctctatgttattactttggattcgaaggtctgatagtgttgctagccgaggaggtagataattcggaatgcgaaattgttagaacctgctggaatgccagcatactggtaagaggctgatctgggggttccccattccccttccaacgatagctgttcgaactctgccgtgccaaaacacgctagccgagcctgttcagagattttcgggcttcaatgtaaagcctcgttatagccaggcacttggaatatggttttctaattatgaagttgccataaggcccgcgaacaaccattgctagctcgtgcctttgtcaactgtactcaatccctggagttagtatccggtgtcggcccagcaacaaaccttccgttctcggcgtcgcaagccctattcacatgttcgcctagggatgggggtgtaggctctactagaagggttctaacgactcctgagaacatgtccagaatcgtttagagggttcggggtggtaataacttgatccgcatcgccgcgtatatagtgcacgcgctcaattaagtaaggcacctgtccgatcctaaagggcttactcaaggtttcccggcggacaggtcttcgtcttgcagtgcgctagcacgccacgtgagcagatgtgcgtatttgaaagaactcaaaggccgcacacgctccggacactggtaacacgcggtctcactacgtagctactattccattctgtcataccttctggttggactttatcatgacgatgttcagttctttgtagtcctaaggctgctgcgatcagcattaatgattacgtgggcgattactctgtctgttgactgtaagggatcagaggcctccgcgagataagatcatcgggaccatttcggagcgagcaaccacctcgtgcgggccgacacaccggcgggcaacccactcttgtattgtttcagtaattttgtacgctgaccttgttatcccgataggtggaagcggtcagtacccagccccgagtcgtgtgtgggtccgtacgccgcacgttgcaccaggaaaagattcatatccttccagacgaagctcccatttatggatgtgggaggggatggtctacttattaaagggcgtggcataagagcctaccccaacgcgcgcttccctatggcaaagtcaatgcctcacgtagctggagttgcgagcctcggacgactgcgcactctcggcgcgaacgtaatcctccactgccttcgtctctcttatacaacgatgctatcccagatttaatctgttacggtatcttaatatgtcagatcacgatcggcagcttaagaagtatggtcaaccgaggtattagtgactagccgattctcgactaacgggaccgacggcaagtgtagcggtgtccagactgtttgtgcttgatggaaaatattatacccacagagtgcactatgtactctaccagtttgcggaccatggacgcacttggagctgcgggatggatgcgacccacccggcggccctacatgcctgcgaccgtgggagcatgatcatcaagagctattaacggggttctgtaaacacaaaagggtaggtgat"),
                        0,
                        [
                            SpliceSite(
                                ReferencePoint(5, 2700),
                                Flags(complement),
                            ),
                        ]
                    ),
                ),
                Insertion(
                    ContigNode(5, pre),
                    ContigNode(5, begin),
                    InsertionInfo(
                        CompressedSequence.from("gcccaggctaaacttgactgccgtagaaccttatcgggtatccagggatgtagtccgtataaaaaacaatcctaaagcgctatgatctgtacaagccggtggggcacatatatcccgttccgcgagtctaatgaatgggttaagcattcactaccactgtagttatttcacgtcctcctaacctacctgactgcagccactaatctggcagagacgcccggcgaaatataattgccgttgagtaaaggaacgagaccgcattgtgttagttgattgttagttgctaaatgtagttttgatgatgcggcccggccgaaggacactattgctttatgcgacccagtatatgagaatttgagttctgtccctgttcaatccgtccggcagaacgttcccttaatgggatctcccgctaagtcctctgacataaactttaggcgctgcgcgctgatgcggcattaaattgaacggaccgcggtcaatatcgttacctgcgtccctttcctgctcgacaagctgttgcctggctgaggaggccaccagacgaatgctacccgttgttgaatcgaggatgcatctgaggtaagtccaggtggctcctgcttattaatttccgcaaccgattaatgtgacacgatccgtgcgtgtggacactggctctatacgttcaaacagaatccaacagtcagcgacgaaaactgaccgtagggatcgagcgcgtgctgaatcacccttttcataaagggggtaccagggcggtgccgttggctcctacaatcggattctttccctggtttttggaaccacgccggtggatgaggcaatgattagattaaacatgcccagacgtttaagccacaccgtccagaaagagcatgtaaaaatcacggatctcttcttgtaaatacttcgcacagatgtgaggttagactaacttactagttgcgagttctcggctatgggggggtaggttatgctgttatggtagatctcgatcagttgccctaaatgtttgtgcttctaaggaccgatgcgggaagtgataggcatgcttctagcatgctggccgtggtgtgtaccaatgcgcaccacttttgcggaatgcactttaggttctccccctaatagttctttatctagacggttattagccaggggaggcgccgaaagcactcgcggatctagggacaggctgagggaacgaccccccacctaagaaattatgatcggaacacgagatcttagtatataaaaggctggatcgcgttgtagacctggcatccatgcgctgtaactgtgaatactccatttttctacattaatgtaagagaattcgtttgcagttgatacacaattgagcggagacaaatagttgggacagatggctttaaaatgcagggacaactagaacacccatcgtgtgtatgcatgcggcatattcgcctagttcacagccttcctaccgccagaagggtctattccagaactactgtaacgagaacggcggtttaattatgtcgaggggaccgcaggattattcggaacggagggtacaaatccagccgtcgtggtcaatgattggcggtctctcctcagtgcgcgtattctccatgtattactggaggaatttgaaggccaacaagggaaaacccgggtcctctcgcatacatttgtcgtcatggaccccctaactacgaagtcataggggattgccgtaaatagttacttcggctttgcggtgtatcgctgggtccctacactcgacgtggttactccccgcggctttgttgtaatcccggatctcgatcacttgcaagctagtatgcgtctcactcggcagtaccacctttcaacggtagagtaacctagttttacgggttggaacctgaacagacaggttcagatgagacgcggtttatcctgcaatccccaggaacctgacactcggtcactattaaccccgatcctgcagtccgccccgcctgggggccaacacaccgcttgaaacactccaaaaaatgtgcctgggggtgttaacgtgctcttaaaaccgaggtggagtcgatgacccagggtcagccgtgttgctgactgccgaccctgtatacgcctcacatgcgccttcgcaaggaacaactggcgaatttgtcccttgtctttgcaaaggtatcttaaagacgacattccgaggacggtccgttactcgtatccccctccatcttagtttgattcctctcggaacactagtctcccgattcgagtccccagaaaacgtatcgggatgcatataaatatctcgaaaccgtaatcatgttcgtttacccacatgcgtatcctggcttgtagcattgcaactaaaggtgtcagaagaaccagtcgagccaagagtagtaaaaacgactgttacccgtacaagaaagctctcgcccgatctatagtcctttaaccggcagttcacgcgttaatcgaactaacgaacgtcccgatccgcaagcgatgccggacaaactctccgtgaagttaacaggctggtctaccgaaagacacccgagactacaccgtgtatcgccacgcttcaattataactcttcgtcgccccgcgtgtgtcccaacttgggggtgatcatgaagatccgctgctagtctaattgtctataaatgtcacgccagttactctttacagcgctgggattgaattcgccctccggtattaaatcttaagctgttgacaatgtacccataatgaatacataaggcctagaaggccaattagtatcataatgatctgcacgactcttgattgcctatcttcattgcgatagcgacgaagacgacccctaggtcattccatcctcatgactatgctgttccctggcggaatacacagcctcttgccaggggaatcttcatcaagctgcttcatggttgaccttcaatatcaaactcagaatatcttagcaccaaacacaccgatgatctggaaccccccgcaaacatcgcacgcccggtttattctcccaatgagcgacgcctgcctatctctcggacaggcttagtagaagcgctgataccttaacaatgatgagtgcaaaccatgtgtggtccccgactggccttgtaggatatgcgaagtacctgacgccagcagcttcgcgccgaactaccctgcagaactgacgtcaaggtcctacggttgatagctgtttctgagggtgcttgggtcccaccgatgcgcttgtggacttgacaccggcgagggaaaccttccaagaaagcctaaaatgcttcacacacagcgacattaatacctcagcaacgttacgctgcaaaattgtatggcctacccatgattacatatttacgctaggtggtgacaccggtcctccagtcattagagtactcgtgattagtcgagatggagccccctgatcgctccgcggagagcagtggatatgtgcacgcccgtaagcatgggggagttccggcagttgggtgctcccgatcacccaactcatatttacggagaacgccggtgcaggataaggacagcaggttgaaggagtccctgcatggatagtataacagctctcgcttgcttccccatagtgggctgtctgagagggttagtctgccgcgagcgtagtgcaataatgagtcagtcgaaggcgagagtccatgggtcttcaaacgccttcgcgagcattgaagaacatgatttaataattgtcatttcatacaatgagtgggtcaccacccaaggcatatgatgtaacaatttcactcttggggccccctttgtttcaacagaaccgctccactcggacgttagtaccgcagacagttggtttcgaattggatatcgagggctaccttgacgttcatcttttaccaatgataccattgtaggaacgcacttgtagggttaggacaatcgaacccgtgccgaccgtgcccaccctaactgaccgcctaagatagctaagagagtatgcaggccagagacgaggccgaatatgactgttatatatatcatccggccccgaccagattacaatgaccccttttgtgaataatagatagaacggaacagagttgaaacctaagtttaagtacaattaatgcggtaacgctgattctagtcttgatgatcccaggccgtagcctgctgtgaccgtctactctgccttcgtcgagcccgactctggccgttttggcctcctcaggagtccgttcacaccatatggcctacttttagtatttgtcaaggctccctgcgtcgcggatctgaatcgtatgtgacagtccgggaaaatttcatcgggcgcgggtatactacatgcaactcggaaaagggatataagccccattcgtgtctctcgcgaaccgcccagggccattagcaacgggaacagcgccaaccgtatttacttatcgcgtaatcagaaagcgtccttactgtcccgtcaccgttctttagactgccggatacggagatgagagtgcattgagtagacacattcgtcgtagaaccggcggagtcatcattgggcaaatttcgacgacttagtccttggcgctggttgtgagtctacgtttggatcactctccttcgcaaggttgctattgtgccgggggtggcatcccaaagagtccctgcaaaccgcaggggctgggattaccgaagacctccatcgacagtgacagcccgccgttcaatagacagcacgatagcgcgagtggaagactgatcacttcggtggttctgtaatgttgtcggtttgtggcaagtctttttgcgcctaacagctcgctcacttcctaccgagctgcttcatccggtccgcatccgctagtgctgcgcttggtgatacctaataaaaattccgcgctgtcggacatcattgttgcttcgtagggatacagcgaagaaggccccaggctcggttgcaacttgcgcgcccttttgaccacgtgaatcggtgacaatgcaaggagcgaatgctcccgatttacgttaggagcgttaagacaatccttcgtcgtaacttgcctcccgtacgtctcctgatgctaggtcagttcgcggaccccacggcatgttaccaccctgagggaagtggatgtggtgcgcagatgactgtgctctctctttccgtcatttcaaatggggtccgaccccactgccatcggttgtccttaacggaggggagcttgggcttcggatcaggtcgtacgacactttgccttgaggggatagagtgaacaactgttggagtatactttgaggtctgtcgtgcatttctgacacagtcgaaatcccatagctaactgggcgttacaaccccatggcggggaaacaagccatttgataagggccgcgctggctgggcgttacccgtgtgcataggccggtgccaacggcgcgctgagagttctatgccctatcagtatggcgatgattcgaatcgaataaggaacgaatagctagttcaaaatccccgtcctggcagtgccacattcgcgattttagcatttacccggagagaaaccccgagctcaggtcagtcatgttccacggctaaatgtattgagagctcatgattgagtcatcgtgacgtgcgacgcgacgctagtcagcaccatttttggctactattttgatttgacagttcatctctcataaaagggagttccgttcggtttgtcttctaaaccccttacacttagtcagaagcgctagcttcagggatgtgtcgttgcacgacgtattctgtttgagcatctaccgtcgatctcccggtaaagaagaaggaagcgtttcctgtccttaggcaactttagggacacaagtactttctgggatataatagatgatcccttggtagagaccttcacagctctacacagacggagt"),
                        0,
                        [
                            SpliceSite(
                                ReferencePoint(5, 2600),
                                emptyFlags,
                            ),
                        ]
                    ),
                ),
            ];
    }

    enum numPileUps = 2;
    enum numReadAlignments = 5;
    enum numSeededAlignments = 7;
    enum numLocalAlignments = 8;
    enum numTracePoints = 393;

    PileUp[] getPileUpsTestData()
    {
        with (AlignmentChain) with (LocalAlignment) with (Flag)
            return [
                [
                    ReadAlignment(
                        SeededAlignment(
                            AlignmentChain(
                                9,
                                Contig(1, 8300),
                                Contig(1539, 6414),
                                Flags(complement),
                                [
                                    LocalAlignment(
                                        Locus(0, 6227),
                                        Locus(7, 6414),
                                        309,
                                        [
                                            TracePoint(10, 98),
                                            TracePoint(7, 107),
                                            TracePoint(7, 105),
                                            TracePoint(8, 108),
                                            TracePoint(4, 99),
                                            TracePoint(4, 102),
                                            TracePoint(5, 103),
                                            TracePoint(5, 105),
                                            TracePoint(1, 101),
                                            TracePoint(8, 107),
                                            TracePoint(6, 102),
                                            TracePoint(8, 103),
                                            TracePoint(7, 105),
                                            TracePoint(6, 105),
                                            TracePoint(2, 102),
                                            TracePoint(4, 104),
                                            TracePoint(5, 101),
                                            TracePoint(5, 99),
                                            TracePoint(0, 100),
                                            TracePoint(0, 100),
                                            TracePoint(10, 107),
                                            TracePoint(7, 103),
                                            TracePoint(5, 102),
                                            TracePoint(4, 101),
                                            TracePoint(2, 100),
                                            TracePoint(7, 106),
                                            TracePoint(1, 101),
                                            TracePoint(5, 101),
                                            TracePoint(7, 107),
                                            TracePoint(6, 106),
                                            TracePoint(3, 103),
                                            TracePoint(3, 103),
                                            TracePoint(7, 105),
                                            TracePoint(4, 103),
                                            TracePoint(5, 102),
                                            TracePoint(7, 103),
                                            TracePoint(7, 104),
                                            TracePoint(5, 105),
                                            TracePoint(5, 101),
                                            TracePoint(8, 106),
                                            TracePoint(4, 102),
                                            TracePoint(9, 104),
                                            TracePoint(2, 100),
                                            TracePoint(6, 102),
                                            TracePoint(8, 104),
                                            TracePoint(8, 106),
                                            TracePoint(6, 102),
                                            TracePoint(4, 102),
                                            TracePoint(2, 101),
                                            TracePoint(4, 102),
                                            TracePoint(4, 103),
                                            TracePoint(3, 103),
                                            TracePoint(4, 101),
                                            TracePoint(8, 108),
                                            TracePoint(2, 102),
                                            TracePoint(2, 101),
                                            TracePoint(3, 103),
                                            TracePoint(2, 100),
                                            TracePoint(3, 103),
                                            TracePoint(5, 102),
                                            TracePoint(6, 105),
                                            TracePoint(3, 98),
                                            TracePoint(1, 28),
                                        ],
                                    ),
                                ],
                            ),
                            AlignmentLocationSeed.front,
                        ),
                    ),
                    ReadAlignment(
                        SeededAlignment(
                            AlignmentChain(
                                17,
                                Contig(1, 8300),
                                Contig(3197, 8564),
                                Flags(complement),
                                [
                                    LocalAlignment(
                                        Locus(0, 71),
                                        Locus(12, 86),
                                        3,
                                        [
                                            TracePoint(3, 74),
                                        ],
                                    ),
                                    LocalAlignment(
                                        Locus(0, 8300),
                                        Locus(0, 8530),
                                        407,
                                        [
                                            TracePoint(6, 105),
                                            TracePoint(9, 108),
                                            TracePoint(7, 105),
                                            TracePoint(3, 103),
                                            TracePoint(2, 100),
                                            TracePoint(5, 100),
                                            TracePoint(6, 104),
                                            TracePoint(7, 104),
                                            TracePoint(5, 99),
                                            TracePoint(4, 104),
                                            TracePoint(2, 101),
                                            TracePoint(3, 103),
                                            TracePoint(6, 102),
                                            TracePoint(7, 102),
                                            TracePoint(8, 102),
                                            TracePoint(4, 104),
                                            TracePoint(4, 104),
                                            TracePoint(6, 99),
                                            TracePoint(7, 104),
                                            TracePoint(6, 105),
                                            TracePoint(3, 99),
                                            TracePoint(5, 102),
                                            TracePoint(3, 103),
                                            TracePoint(5, 103),
                                            TracePoint(4, 104),
                                            TracePoint(7, 104),
                                            TracePoint(6, 106),
                                            TracePoint(6, 105),
                                            TracePoint(7, 105),
                                            TracePoint(2, 100),
                                            TracePoint(2, 101),
                                            TracePoint(9, 101),
                                            TracePoint(6, 104),
                                            TracePoint(4, 102),
                                            TracePoint(6, 101),
                                            TracePoint(7, 104),
                                            TracePoint(8, 103),
                                            TracePoint(7, 107),
                                            TracePoint(3, 103),
                                            TracePoint(5, 103),
                                            TracePoint(3, 103),
                                            TracePoint(3, 101),
                                            TracePoint(7, 104),
                                            TracePoint(1, 101),
                                            TracePoint(8, 103),
                                            TracePoint(3, 103),
                                            TracePoint(1, 101),
                                            TracePoint(4, 103),
                                            TracePoint(4, 103),
                                            TracePoint(5, 104),
                                            TracePoint(4, 99),
                                            TracePoint(3, 103),
                                            TracePoint(5, 103),
                                            TracePoint(4, 102),
                                            TracePoint(3, 99),
                                            TracePoint(4, 98),
                                            TracePoint(8, 108),
                                            TracePoint(4, 104),
                                            TracePoint(6, 106),
                                            TracePoint(7, 106),
                                            TracePoint(7, 105),
                                            TracePoint(3, 103),
                                            TracePoint(4, 101),
                                            TracePoint(1, 101),
                                            TracePoint(6, 102),
                                            TracePoint(7, 104),
                                            TracePoint(1, 101),
                                            TracePoint(5, 98),
                                            TracePoint(8, 104),
                                            TracePoint(5, 104),
                                            TracePoint(4, 104),
                                            TracePoint(5, 102),
                                            TracePoint(4, 103),
                                            TracePoint(4, 100),
                                            TracePoint(3, 103),
                                            TracePoint(6, 104),
                                            TracePoint(7, 103),
                                            TracePoint(4, 104),
                                            TracePoint(5, 103),
                                            TracePoint(5, 102),
                                            TracePoint(2, 100),
                                            TracePoint(7, 102),
                                            TracePoint(5, 105),
                                        ],
                                    ),
                                ],
                            ),
                            AlignmentLocationSeed.front,
                        ),
                    ),
                ],
                [
                    ReadAlignment(
                        SeededAlignment(
                            AlignmentChain(
                                42,
                                Contig(1, 8300),
                                Contig(2325, 16069),
                                emptyFlags,
                                [
                                    LocalAlignment(
                                        Locus(3562, 8300),
                                        Locus(0, 4860),
                                        229,
                                        [
                                            TracePoint(3, 41),
                                            TracePoint(7, 102),
                                            TracePoint(2, 102),
                                            TracePoint(3, 103),
                                            TracePoint(4, 102),
                                            TracePoint(8, 108),
                                            TracePoint(2, 100),
                                            TracePoint(6, 102),
                                            TracePoint(6, 104),
                                            TracePoint(2, 102),
                                            TracePoint(4, 102),
                                            TracePoint(7, 102),
                                            TracePoint(3, 99),
                                            TracePoint(2, 102),
                                            TracePoint(3, 100),
                                            TracePoint(6, 100),
                                            TracePoint(3, 102),
                                            TracePoint(5, 104),
                                            TracePoint(5, 104),
                                            TracePoint(4, 101),
                                            TracePoint(5, 103),
                                            TracePoint(2, 102),
                                            TracePoint(7, 106),
                                            TracePoint(7, 103),
                                            TracePoint(3, 101),
                                            TracePoint(8, 106),
                                            TracePoint(6, 103),
                                            TracePoint(6, 103),
                                            TracePoint(4, 103),
                                            TracePoint(3, 102),
                                            TracePoint(2, 101),
                                            TracePoint(7, 106),
                                            TracePoint(4, 104),
                                            TracePoint(3, 101),
                                            TracePoint(8, 103),
                                            TracePoint(10, 102),
                                            TracePoint(8, 104),
                                            TracePoint(7, 102),
                                            TracePoint(3, 103),
                                            TracePoint(5, 105),
                                            TracePoint(6, 100),
                                            TracePoint(7, 105),
                                            TracePoint(3, 99),
                                            TracePoint(3, 100),
                                            TracePoint(5, 104),
                                            TracePoint(4, 104),
                                            TracePoint(3, 100),
                                            TracePoint(5, 103),
                                        ],
                                    ),
                                ],
                            ),
                            AlignmentLocationSeed.back,
                        ),
                        SeededAlignment(
                            AlignmentChain(
                                76,
                                Contig(2, 8350),
                                Contig(2325, 16069),
                                emptyFlags,
                                [
                                    LocalAlignment(
                                        Locus(0, 6798),
                                        Locus(9086, 16069),
                                        308,
                                        [
                                            TracePoint(5, 103),
                                            TracePoint(4, 101),
                                            TracePoint(8, 106),
                                            TracePoint(9, 104),
                                            TracePoint(9, 104),
                                            TracePoint(6, 106),
                                            TracePoint(3, 101),
                                            TracePoint(8, 104),
                                            TracePoint(4, 104),
                                            TracePoint(7, 101),
                                            TracePoint(4, 102),
                                            TracePoint(3, 100),
                                            TracePoint(7, 105),
                                            TracePoint(6, 99),
                                            TracePoint(3, 103),
                                            TracePoint(2, 102),
                                            TracePoint(6, 102),
                                            TracePoint(3, 103),
                                            TracePoint(4, 102),
                                            TracePoint(12, 110),
                                            TracePoint(7, 103),
                                            TracePoint(4, 104),
                                            TracePoint(4, 102),
                                            TracePoint(4, 100),
                                            TracePoint(5, 105),
                                            TracePoint(5, 100),
                                            TracePoint(6, 102),
                                            TracePoint(5, 105),
                                            TracePoint(3, 102),
                                            TracePoint(2, 102),
                                            TracePoint(6, 103),
                                            TracePoint(2, 100),
                                            TracePoint(4, 104),
                                            TracePoint(5, 103),
                                            TracePoint(6, 104),
                                            TracePoint(4, 104),
                                            TracePoint(3, 101),
                                            TracePoint(4, 104),
                                            TracePoint(6, 104),
                                            TracePoint(4, 104),
                                            TracePoint(1, 101),
                                            TracePoint(3, 103),
                                            TracePoint(8, 105),
                                            TracePoint(2, 102),
                                            TracePoint(4, 104),
                                            TracePoint(1, 99),
                                            TracePoint(6, 102),
                                            TracePoint(3, 101),
                                            TracePoint(3, 101),
                                            TracePoint(5, 105),
                                            TracePoint(1, 101),
                                            TracePoint(1, 100),
                                            TracePoint(4, 102),
                                            TracePoint(4, 101),
                                            TracePoint(3, 103),
                                            TracePoint(2, 101),
                                            TracePoint(5, 101),
                                            TracePoint(6, 103),
                                            TracePoint(6, 105),
                                            TracePoint(7, 106),
                                            TracePoint(8, 107),
                                            TracePoint(5, 103),
                                            TracePoint(5, 105),
                                            TracePoint(2, 102),
                                            TracePoint(2, 100),
                                            TracePoint(1, 100),
                                            TracePoint(5, 103),
                                            TracePoint(3, 99),
                                        ],
                                    ),
                                ],
                            ),
                            AlignmentLocationSeed.front,
                        ),
                   ),
                    ReadAlignment(
                        SeededAlignment(
                            AlignmentChain(
                                47,
                                Contig(1, 8300),
                                Contig(3332, 12946),
                                Flags(complement),
                                [
                                    LocalAlignment(
                                        Locus(4899, 8300),
                                        Locus(0, 3507),
                                        154,
                                        [
                                            TracePoint(0, 1),
                                            TracePoint(7, 105),
                                            TracePoint(6, 105),
                                            TracePoint(6, 106),
                                            TracePoint(7, 107),
                                            TracePoint(3, 102),
                                            TracePoint(7, 105),
                                            TracePoint(3, 103),
                                            TracePoint(2, 102),
                                            TracePoint(4, 100),
                                            TracePoint(3, 101),
                                            TracePoint(5, 105),
                                            TracePoint(3, 103),
                                            TracePoint(7, 101),
                                            TracePoint(3, 101),
                                            TracePoint(5, 102),
                                            TracePoint(7, 105),
                                            TracePoint(4, 104),
                                            TracePoint(3, 103),
                                            TracePoint(4, 104),
                                            TracePoint(3, 103),
                                            TracePoint(6, 102),
                                            TracePoint(4, 101),
                                            TracePoint(6, 104),
                                            TracePoint(2, 102),
                                            TracePoint(8, 104),
                                            TracePoint(4, 104),
                                            TracePoint(4, 103),
                                            TracePoint(1, 99),
                                            TracePoint(0, 100),
                                            TracePoint(9, 108),
                                            TracePoint(5, 104),
                                            TracePoint(5, 102),
                                            TracePoint(5, 103),
                                            TracePoint(3, 103),
                                        ],
                                    ),
                                ],
                            ),
                            AlignmentLocationSeed.back,
                        ),
                        SeededAlignment(
                            AlignmentChain(
                                89,
                                Contig(2, 8350),
                                Contig(3332, 12946),
                                Flags(complement),
                                [
                                    LocalAlignment(
                                        Locus(0, 5082),
                                        Locus(7726, 12946),
                                        244,
                                        [
                                            TracePoint(5, 104),
                                            TracePoint(2, 99),
                                            TracePoint(3, 103),
                                            TracePoint(7, 103),
                                            TracePoint(2, 98),
                                            TracePoint(2, 102),
                                            TracePoint(11, 107),
                                            TracePoint(4, 104),
                                            TracePoint(4, 102),
                                            TracePoint(8, 106),
                                            TracePoint(5, 105),
                                            TracePoint(11, 109),
                                            TracePoint(8, 101),
                                            TracePoint(5, 103),
                                            TracePoint(4, 104),
                                            TracePoint(2, 102),
                                            TracePoint(7, 105),
                                            TracePoint(3, 103),
                                            TracePoint(5, 101),
                                            TracePoint(3, 101),
                                            TracePoint(5, 102),
                                            TracePoint(4, 102),
                                            TracePoint(6, 103),
                                            TracePoint(5, 105),
                                            TracePoint(3, 99),
                                            TracePoint(5, 103),
                                            TracePoint(2, 100),
                                            TracePoint(7, 105),
                                            TracePoint(3, 101),
                                            TracePoint(5, 105),
                                            TracePoint(5, 103),
                                            TracePoint(5, 105),
                                            TracePoint(5, 105),
                                            TracePoint(7, 105),
                                            TracePoint(5, 102),
                                            TracePoint(3, 100),
                                            TracePoint(3, 102),
                                            TracePoint(4, 102),
                                            TracePoint(5, 103),
                                            TracePoint(5, 105),
                                            TracePoint(8, 100),
                                            TracePoint(6, 103),
                                            TracePoint(5, 102),
                                            TracePoint(6, 105),
                                            TracePoint(2, 98),
                                            TracePoint(2, 100),
                                            TracePoint(7, 104),
                                            TracePoint(5, 104),
                                            TracePoint(3, 103),
                                            TracePoint(2, 100),
                                            TracePoint(5, 82),
                                        ],
                                    ),
                                ],
                            ),
                            AlignmentLocationSeed.front,
                        )
                    ),
                    ReadAlignment(
                        SeededAlignment(
                            AlignmentChain(
                                43,
                                Contig(1, 8300),
                                Contig(3593, 6783),
                                emptyFlags,
                                [
                                    LocalAlignment(
                                        Locus(3943, 8300),
                                        Locus(0, 4471),
                                        213,
                                        [
                                            TracePoint(3, 56),
                                            TracePoint(7, 102),
                                            TracePoint(2, 102),
                                            TracePoint(7, 101),
                                            TracePoint(7, 103),
                                            TracePoint(9, 107),
                                            TracePoint(4, 104),
                                            TracePoint(4, 104),
                                            TracePoint(5, 100),
                                            TracePoint(4, 104),
                                            TracePoint(3, 101),
                                            TracePoint(5, 102),
                                            TracePoint(5, 101),
                                            TracePoint(2, 102),
                                            TracePoint(2, 98),
                                            TracePoint(6, 102),
                                            TracePoint(10, 109),
                                            TracePoint(1, 99),
                                            TracePoint(6, 102),
                                            TracePoint(1, 101),
                                            TracePoint(3, 101),
                                            TracePoint(5, 104),
                                            TracePoint(7, 101),
                                            TracePoint(7, 105),
                                            TracePoint(5, 102),
                                            TracePoint(0, 100),
                                            TracePoint(4, 104),
                                            TracePoint(10, 105),
                                            TracePoint(7, 103),
                                            TracePoint(11, 111),
                                            TracePoint(8, 105),
                                            TracePoint(4, 101),
                                            TracePoint(4, 103),
                                            TracePoint(3, 100),
                                            TracePoint(5, 104),
                                            TracePoint(4, 102),
                                            TracePoint(7, 105),
                                            TracePoint(5, 105),
                                            TracePoint(6, 104),
                                            TracePoint(5, 102),
                                            TracePoint(3, 103),
                                            TracePoint(3, 101),
                                            TracePoint(2, 100),
                                            TracePoint(2, 100),
                                        ],
                                    ),
                                ],
                            ),
                            AlignmentLocationSeed.back,
                        )
                    ),
                ],
            ];
    }
}