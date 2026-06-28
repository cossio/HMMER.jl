# HMMER.jl

A thin Julia wrapper of [HMMER](http://hmmer.org). Functions have the same name
as the HMMER programs (and Easel miniapps), and keyword arguments are named
consistently with the command-line arguments of the respective programs. Each
function creates temporary files for its output and returns a named tuple with
the spawned process, the captured `stdout`/`stderr`, and the output paths.

## Installation

This package is registered. Install it with:

```julia
import Pkg
Pkg.add("HMMER")
```

## Contents

```@contents
Pages = ["literate/tutorial.md", "reference.md"]
Depth = 2
```

## Related packages

- [Rfam.jl](https://github.com/cossio/Rfam.jl)
- [Infernal.jl](https://github.com/cossio/Infernal.jl)
