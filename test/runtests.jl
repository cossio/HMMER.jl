import Pfam
using Test: @test
using Test: @testset

Pfam.set_pfam_directory(mktempdir())
Pfam.set_pfam_version("35.0")

@test isfile(Pfam.Pfam_A_hmm())

module aqua_tests include("aqua.jl") end
module hmmer_tests include("hmmer_programs.jl") end
module easel_tests include("easel_miniapps.jl") end
