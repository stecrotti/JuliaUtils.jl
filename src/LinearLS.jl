struct LinearLS{T<:Real}
    x :: Vector{T}  # x data
    y :: Vector{T}  # y data
    f :: Function   # y = m*f(x) + q
    m :: Float64    # slope
    q :: Float64    # intercept
    function LinearLS(x::AbstractVector{T1}, y::AbstractVector{T2}, f::Function,
        m::Real, q::Real) where {T1<:Real, T2<:Real}
        T = promote_type(eltype(x), eltype(y))
        new{T}(Vector{T}(x), Vector{T}(y), f, m, q)
    end
end

function Base.show(io::IO, ls::LinearLS)
    println(io, "Linear fit Y ~ m*f(X) + q")
    println(io, "\tf = ", ls.f)
    println(io, "\tm = ", ls.m)
    println(io, "\tq = ", ls.q)
end

"""
    linearls(x::AbstractVector, y::AbstractVector, f::Function=x->x)
 
Linear fit for `y = m*f(x) + q`.
Return a `LinearLS` object storing the estimated `m, q` 

"""
function linearls(x::AbstractVector, y::AbstractVector, f::Function=identity)
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
