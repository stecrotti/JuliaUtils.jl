using JuliaUtils
using Test

@testset "LinearLS - two datapoints" begin
    x = [1, 2]
    y = [4, 5]
    ls = linearls(x, y)
    @test ls.m == 1
    @test ls.q == 3
end

@testset "Newton - exp" begin
    f(x) = exp(x) - 1
    x0 = 2
    x = newton(f, x0, tol=1e-20, niters=10^3)
    @test isapprox(x, 0, atol=1e-10)
end