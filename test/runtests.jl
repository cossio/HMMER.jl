using Test: @test, @testset
import HMMER
import Pfam

dir = mktempdir()

stk_file = Pfam.alignment_file("PF00013"; dir)
out = HMMER.esl_reformat("afa", stk_file)
@test isfile(out.o)
