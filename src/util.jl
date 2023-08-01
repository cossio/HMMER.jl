const Opt{T} = Union{Nothing,T}

function hmmer_cmd(name::AbstractString)
    binary = joinpath(artifact"hmmer", "bin", name)
    return `$binary`
end
