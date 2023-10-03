using Test: @test, @testset
using Pfam: alignment_file
using HMMER: esl_reformat

@testset "esl_reformat" begin
    stk_file = alignment_file("PF00013")
    out = esl_reformat("afa", stk_file)
    @test isfile(out.o)
end
