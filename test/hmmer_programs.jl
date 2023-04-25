using Test: @test, @testset
import ..PFAM_VERSION, ..PFAM_DIR
import Pfam
using HMMER: hmmfetch

@testset "hmmfetch" begin
    pfam_hmm = Pfam.Pfam_A_hmm(; dir=PFAM_DIR, version=PFAM_VERSION)
    @test isfile(hmmfetch(pfam_hmm, "PF00397.29").o)
end
