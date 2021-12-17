"""
    newton(f::Function, x0::Real; niters=10^2, tol=1e-8)

Compute roots of scalar `f` by Newton's method

"""

function newton(f::Function, x0::Real; niters=10^2, tol=1e-8)
    x = xnew = x0
    for it in 1:niters
        df = ForwardDiff.derivative(f, x)
        xnew = x - f(x)/df
        abs(x - xnew) < tol && return xnew
        x, xnew = xnew, x
    end
    xnew
end