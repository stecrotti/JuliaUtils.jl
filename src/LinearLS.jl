struct LinearLS{T<:Real}
    x :: Vector{T}
    y :: Vector{T}
    f :: Function
    m :: Float64
    q :: Float64
end

function linearls(x::AbstractVector, y::AbstractVector, f::Function=x->x)
    X = [f.(x) ones(length(x))]
    m, q = X \ y
    LinearLS(x, y, f, m, q)
end

function predict(ls::LinearLS, x::AbstractVector)
    ls.f.(x) .* ls.m .+ ls.q
end

function Plots.plot!(pl::Plots.Plot, ls::LinearLS;
        pointslabel="Data", fitlabel="Fit", kw...)
    (xmin, xmax) = extrema(ls.x)
    xspan = xmax - xmin
    Plots.scatter!(pl, ls.x, ls.y, label=pointslabel)
    xrange = LinRange(xmin-0.2*xspan, xmax+0.2*xspan, 10*length(ls.x))
    Plots.plot!(pl, xrange, predict(ls, xrange); label=fitlabel, kw...)
    pl
end