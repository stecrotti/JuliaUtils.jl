struct LinearLS{T<:Real}
    x :: Vector{T}  # x data
    y :: Vector{T}  # y data
    f :: Function   # y = m*f(x) + q
    w :: Vector{T}  # weights (inverse a priori error on the `y`'s)
    m :: Float64    # slope
    q :: Float64    # intercept
    function LinearLS(x::AbstractVector{<:Real}, y::AbstractVector{<:Real}, 
        f::Function, w::AbstractVector{<:Real}, m::Real, q::Real) 
        T = promote_type(eltype(x), eltype(y), eltype(w))
        new{T}(Vector{T}(x), Vector{T}(y), f, Vector{T}(w), m, q)
    end
end

function Base.show(io::IO, ls::LinearLS)
    println(io, "Linear fit Y ~ m*f(X) + q")
    println(io, "\tf = ", ls.f)
    println(io, "\tm = ", ls.m)
    println(io, "\tq = ", ls.q)
end

"""
    linearls(x::AbstractVector, y::AbstractVector, f::Function=identity;
        weights=ones(length(x)))
 
Linear fit for `y = m*f(x) + q`.
Return a `LinearLS` object storing the estimated `m, q` 
Optionally provide `weights` for Weighted LS

"""
function linearls(x::AbstractVector, y::AbstractVector, f::Function=identity;
        weights=ones(length(x)))
    X = diagm(weights) * [f.(x) ones(length(x))]
    Y = weights .* y
    m, q = X \ Y
    LinearLS(x, y, f, weights, m, q)
end

"""
    predict(ls::LinearLS, x::AbstractVector)

Predict new values based on the linear fit object `ls`. See `linearls`

"""
function predict(ls::LinearLS, x::AbstractVector)
    ls.f.(x) .* ls.m .+ ls.q
end
