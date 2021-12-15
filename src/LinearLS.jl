struct LinearLS{T<:Real}
    x :: Vector{T}  # x data
    y :: Vector{T}  # y data
    f :: Function   # y = m*f(x) + q
    m :: Float64    # slope
    q :: Float64    # intercept
end

"""
    linearls(x::AbstractVector, y::AbstractVector, f::Function=x->x)

Linear fit for `y = m*f(x) + q`.
Return a `LinearLS` object storing the estimated `m, q` 

"""
function linearls(x::AbstractVector, y::AbstractVector, f::Function=x->x)
    X = [f.(x) ones(length(x))]
    m, q = X \ y
    LinearLS(x, y, f, m, q)
end

"""
    predict(ls::LinearLS, x::AbstractVector)

Predict new values based on the linear fit object `ls`. See `linearls`

"""
function predict(ls::LinearLS, x::AbstractVector)
    ls.f.(x) .* ls.m .+ ls.q
end