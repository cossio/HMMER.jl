# Internal module used in tests
# Loading artifacts is tricky in tests, so we declare the artifact here instead.
module _Testing

using LazyArtifacts: LazyArtifacts, @artifact_str

# WW sequences from Hu 2004 paper, "A map of WW domain family interactions". Used for tests.
Hu2004_sequences_path() = joinpath(artifact"20230425_WW_Hu_2004", "WW_2004.tsv")

end # module
