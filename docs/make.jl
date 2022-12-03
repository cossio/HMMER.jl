using HMMER
using Documenter

DocMeta.setdocmeta!(HMMER, :DocTestSetup, :(using HMMER); recursive=true)

makedocs(;
    modules=[HMMER],
    authors="Jorge Fernandez-de-Cossio-Diaz <cossio@users.noreply.github.com> and contributors",
    repo="https://github.com/cossio/HMMER.jl/blob/{commit}{path}#{line}",
    sitename="HMMER.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://cossio.github.io/HMMER.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/cossio/HMMER.jl",
    devbranch="main",
)
