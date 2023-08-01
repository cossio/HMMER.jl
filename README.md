# HMMER.jl

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://cossio.github.io/HMMER.jl/stable/)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://cossio.github.io/HMMER.jl/dev/)
![](https://github.com/cossio/HMMER.jl/workflows/CI/badge.svg)
[![Coverage](https://codecov.io/gh/cossio/HMMER.jl/branch/main/graph/badge.svg)](https://codecov.io/gh/cossio/HMMER.jl)

A thin Julia wrapper of [hmmer](http://hmmer.org). Functions have the same name as the HMMER programs (and Easel miniapps). Keyword arguments are named consistently with the command line arguments of the respective programs. The package creates temporary files for output and returns the path.

## Installation

This package is registered. Install with:

```julia
import Pkg
Pkg.add("HMMER")
```