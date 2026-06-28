import Documenter
import Literate
import HMMER

# Run Literate.jl over the tutorial sources, generating Markdown files next to
# them. The generated `.md` files are git-ignored (see `.gitignore`).
const literate_dir = joinpath(@__DIR__, "src", "literate")
for file in readdir(literate_dir; join = true)
    if endswith(file, ".jl")
        Literate.markdown(file, literate_dir; documenter = true)
    end
end

Documenter.makedocs(
    modules = [HMMER],
    sitename = "HMMER.jl",
    authors = "Jorge Fernandez-de-Cossio-Diaz",
    repo = Documenter.Remotes.GitHub("cossio", "HMMER.jl"),
    pages = [
        "Home" => "index.md",
        "Tutorial" => "literate/tutorial.md",
        "Reference" => "reference.md",
    ],
    format = Documenter.HTML(;
        prettyurls = get(ENV, "CI", "false") == "true",
        canonical = "https://cossio.github.io/HMMER.jl/stable/",
    ),
)

Documenter.deploydocs(
    repo = "github.com/cossio/HMMER.jl.git",
    devbranch = "main",
    push_preview = true,
)
