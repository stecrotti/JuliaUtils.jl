using JuliaUtils
using Test

@testset "Two datapoints" begin
    x = [1, 2]
    y = [4, 5]
    ls = linearls(x, y)
    @test ls.m == 1
    @test ls.q == 3
end
