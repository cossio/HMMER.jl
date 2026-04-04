using Test: @test, @testset
using HMMER: esl_reformat
using Main.HMMERTestFixtures: fasta_sequences, write_test_alignment

@testset "esl_reformat" begin
    stk_file = write_test_alignment()
    out = esl_reformat("afa", stk_file; informat="stockholm", wait=false)

    @test process_running(out.process)
    wait(out.process)
    @test success(out.process)

    @test isfile(out.o)
    @test isfile(out.stdout)
    @test isfile(out.stderr)
    @test fasta_sequences(out.o) == Dict(
        "seq1" => "ACDEFGHIK",
        "seq2" => "ACDEYGHIK",
        "seq3" => "ACDEWGHIK",
    )
end
