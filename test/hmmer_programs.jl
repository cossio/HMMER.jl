using Test: @test, @testset
using HMMER: hmmalign, hmmbuild, hmmfetch, hmmsearch
using Main.HMMERTestFixtures: normalized_alignment_sequences, write_test_alignment, write_test_fasta

function build_test_hmm(; wait=true)
    return hmmbuild(write_test_alignment(); wait, n="tiny", amino=true)
end

@testset "hmmbuild" begin
    build = build_test_hmm(wait=false)

    @test process_running(build.process)
    wait(build.process)
    @test success(build.process)

    @test all(isfile, (build.stdout, build.stderr, build.hmmout, build.o, build.O))

    summary = read(build.o, String)
    @test occursin("name (the single) HMM:            tiny", summary)
    @test occursin("input alignment is asserted as:   protein", summary)
end

@testset "hmmsearch" begin
    build = build_test_hmm()
    seqdb = write_test_fasta()
    search = hmmsearch(build.hmmout, seqdb; wait=false, Z=3, E=1000.0, cpu=1)

    @test process_running(search.process)
    wait(search.process)
    @test success(search.process)

    @test all(isfile, (search.stdout, search.stderr, search.o, search.A, search.tblout, search.domtblout))

    tblout = read(search.tblout, String)
    @test occursin("hit1", tblout)
    @test occursin("hit2", tblout)
    @test !occursin("miss", tblout)
    @test occursin("-E 1000.0", tblout)
    @test occursin("-Z 3", tblout)
    @test occursin("--cpu 1", tblout)
end

@testset "hmmfetch" begin
    build = build_test_hmm()
    fetch = hmmfetch(build.hmmout, "tiny"; wait=false)

    @test process_running(fetch.process)
    wait(fetch.process)
    @test success(fetch.process)

    @test all(isfile, (fetch.stdout, fetch.stderr, fetch.o))
    @test occursin("NAME  tiny", read(fetch.o, String))
end

@testset "hmmalign" begin
    build = build_test_hmm()
    seqdb = write_test_fasta()
    aln = hmmalign(build.hmmout, seqdb; wait=false, informat="fasta", outformat="afa")

    @test process_running(aln.process)
    wait(aln.process)
    @test success(aln.process)

    @test all(isfile, (aln.stdout, aln.stderr, aln.o))

    aligned_sequences = normalized_alignment_sequences(aln.o)
    @test aligned_sequences["hit1"] == "ACDEFGHIK"
    @test aligned_sequences["hit2"] == "ACDEWGHIK"
    @test aligned_sequences["miss"] == "T"
end
