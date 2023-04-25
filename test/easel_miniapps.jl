using Test: @test, @testset
import ..PFAM_VERSION, ..PFAM_DIR
using Pfam: alignment_file
using HMMER: esl_reformat

@testset "esl_reformat" begin
    stk_file = alignment_file("PF00013"; dir=PFAM_DIR)
    out = esl_reformat("afa", stk_file)
    @test isfile(out.o)
end
