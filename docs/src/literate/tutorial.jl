# # Tutorial
#
# This tutorial shows how to use `HMMER.jl` to build a profile HMM, search a
# sequence database, fetch a profile, align sequences, and reformat alignments.
# Every function wraps the corresponding HMMER program (or Easel miniapp) and
# returns a named tuple containing the spawned `process`, the captured
# `stdout`/`stderr`, and the paths of the generated output files.

import HMMER

# ## Build a profile
#
# We start from a small multiple-sequence alignment in Stockholm format and
# build a profile HMM with [`HMMER.hmmbuild`](@ref). The `amino` keyword forces
# the amino-acid alphabet and `n` sets the model name.

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

model = HMMER.hmmbuild(alignment; amino=true, n="toy_profile")

# The profile HMM is written to `model.hmmout`, and a human-readable summary to
# `model.o`:

print(read(model.o, String))

# ## Search a sequence database
#
# We can now search a FASTA database for matches to the profile with
# [`HMMER.hmmsearch`](@ref). The per-sequence hit table is written to
# `hits.tblout`.

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

hits = HMMER.hmmsearch(model.hmmout, seqdb)

print(read(hits.tblout, String))

# ## Fetch a profile
#
# [`HMMER.hmmfetch`](@ref) extracts a single profile (by name) from an HMM
# database into its own file, available at `profile.o`.

profile = HMMER.hmmfetch(model.hmmout, "toy_profile")

# ## Align sequences to a profile
#
# [`HMMER.hmmalign`](@ref) aligns sequences against a profile HMM. Here we use
# the profile fetched above and request aligned FASTA output via `outformat`.

seqfile = tempname()
write(
    seqfile,
    """
    >seq1
    ACDEFGHIK
    >seq2
    ACDEYGHIK
    """,
)

aligned = HMMER.hmmalign(profile.o, seqfile; outformat="afa")

print(read(aligned.o, String))

# ## Reformat an alignment with Easel
#
# Finally, [`HMMER.esl_reformat`](@ref) converts a sequence or alignment file to
# another format. Here we convert a Stockholm alignment to aligned FASTA.

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

fasta = HMMER.esl_reformat("afa", stockholm)

print(read(fasta.o, String))
