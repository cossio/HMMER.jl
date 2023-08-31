module HMMER

import HMMER_jll
using LazyArtifacts: LazyArtifacts, @artifact_str

# include("util.jl")
# include("hmmer_artifact.jl")
include("hmmer_programs.jl")
include("easel_miniapps.jl")

include("_tests.jl")

end
