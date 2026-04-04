using Test: @testset

include("fixtures.jl")

module aqua_tests include("aqua.jl") end
module hmmer_tests include("hmmer_programs.jl") end
module easel_tests include("easel_miniapps.jl") end
