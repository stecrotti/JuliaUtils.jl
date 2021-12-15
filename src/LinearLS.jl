struct LinearLS{T<:Real}
    x :: Vector{T}  # x data
    y :: Vector{T}  # y data
    f :: Function   # y = m*f(x) + q
    m :: Float64    # slope
    q :: Float64    # intercept
end

function linearls(x::AbstractVector, y::AbstractVector, f::Function=x->x)
    X = [f.(x) ones(length(x))]
    m, q = X \ y
    LinearLS(x, y, f, m, q)
end

function predict(ls::LinearLS, x::AbstractVector)
    ls.f.(x) .* ls.m .+ ls.q
end