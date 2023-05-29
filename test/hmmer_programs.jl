import ..PFAM_VERSION, ..PFAM_DIR
import Pfam
import CSV
import FASTX

using Test: @test, @testset
using HMMER: hmmfetch, hmmalign
using HMMER._Testing: Hu2004_sequences_path
using DataFrames: DataFrame

@testset "hmmfetch" begin
    pfam_hmm = Pfam.Pfam_A_hmm(; dir=PFAM_DIR, version=PFAM_VERSION)
    @test isfile(hmmfetch(pfam_hmm, "PF00397.29").o)
end

@testset "hmmalign" begin
    hu2004_sequences = DataFrame(CSV.File(Hu2004_sequences_path(), delim='\t')).WW

    # prepare FASTA
    hu2004_fasta = tempname()
    FASTX.FASTA.Writer(open(hu2004_fasta, "w")) do writer
        for (i, seq) in enumerate(hu2004_sequences)
            write(writer, FASTX.FASTA.Record(string(i), seq))
        end
    end

    # align
    pfam_hmm = Pfam.Pfam_A_hmm(; dir=PFAM_DIR, version=PFAM_VERSION)
    hmm = hmmfetch(pfam_hmm, "PF00397.29").o
    aln = hmmalign(hmm, hu2004_fasta; outformat="afa")

    # load aligned sequences from aln.o output file
    aligned_sequences = String[]
    FASTX.FASTA.Reader(open(aln.o)) do reader
        for record in reader
            push!(aligned_sequences, filter(c -> !islowercase(c) && c != '.', FASTX.sequence(record)))
        end
    end

    @test all(length.(aligned_sequences) .== 31)
end
