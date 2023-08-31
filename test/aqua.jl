import Aqua
import HMMER
using Test: @testset

@testset "aqua" begin
    Aqua.test_all(HMMER)
end
