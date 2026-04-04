# HMMER.jl

A thin Julia wrapper of [hmmer](http://hmmer.org). Functions have the same name as the HMMER programs (and Easel miniapps). Keyword arguments are named consistently with the command line arguments of the respective programs. The package creates temporary files for output and returns the path.

## Installation

This package is registered. Install with:

```julia
import Pkg
Pkg.add("HMMER")
```

## Examples

### Build a profile and search a sequence database

```julia
using HMMER

alignment = tempname()
write(
    alignment,
    """
    # STOCKHOLM 1.0
    seq1 ACDEFGHIK
    seq2 ACDEYGHIK
    //
    """,
)

model = hmmbuild(alignment; amino=true, n="toy_profile")

seqdb = tempname()
write(
    seqdb,
    """
    >match
    ACDEFGHIK
    >nonmatch
    TTTTTTTTT
    """,
)

hits = hmmsearch(model.hmmout, seqdb)

read(hits.tblout, String)
```

### Fetch a profile and align sequences to it

```julia
using HMMER

alignment = tempname()
write(
    alignment,
    """
    # STOCKHOLM 1.0
    seq1 AYV
    seq2 AFV
    //
    """,
)

model = hmmbuild(alignment; amino=true, n="toy_profile")
profile = hmmfetch(model.hmmout, "toy_profile")

seqfile = tempname()
write(
    seqfile,
    """
    >seq1
    AYV
    >seq2
    AFV
    """,
)

aligned = hmmalign(profile.o, seqfile; outformat="afa")

read(aligned.o, String)
```

### Convert an alignment to FASTA

```julia
using HMMER

stockholm = tempname()
write(
    stockholm,
    """
    # STOCKHOLM 1.0
    seq1 ACDE
    seq2 AC-E
    //
    """,
)

fasta = esl_reformat("afa", stockholm)

read(fasta.o, String)
```
