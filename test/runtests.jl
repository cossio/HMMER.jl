using Test: @test, @testset
import Pfam

const PFAM_VERSION = "35.0"
const PFAM_DIR = mktempdir()

@test isfile(Pfam.Pfam_A_hmm(; dir=PFAM_DIR, version=PFAM_VERSION))

module hmmer_tests include("hmmer_programs.jl") end
module easel_tests include("easel_miniapps.jl") end
