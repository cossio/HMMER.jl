module HMMER

using LazyArtifacts: LazyArtifacts, @artifact_str

include("util.jl")
include("hmmer_programs.jl")
include("easel_miniapps.jl")

include("_tests.jl")

end
