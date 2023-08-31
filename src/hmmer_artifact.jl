#= We can use HMMER from a pre-compiled artifact, or from HMMER_jll. The later is preferred
(if it works), so I am not using this artifact for now. =#

function hmmer_cmd(name::AbstractString)
    binary = joinpath(artifact"hmmer", "bin", name)
    return `$binary`
end
