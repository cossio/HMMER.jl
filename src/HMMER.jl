module HMMER

import HMMER_jll

const Opt{T} = Union{Nothing,T}

include("hmmer_programs.jl")
include("easel_miniapps.jl")

include("_tests.jl")

end
