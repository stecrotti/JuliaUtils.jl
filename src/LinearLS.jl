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