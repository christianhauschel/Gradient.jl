module Gradient

using FLOWMath

export gradient

"""
    gradient(x, y; method=:akima)

Calculates the gradient dy/dx of numerical data 
linearly or using an Akima spline.

# Arguments
* `x::Vector`
* `y::Array`: vector or matrix
* `method::Symbol`: `:akima` or `:linear`
"""
function gradient(x::Vector, y::Array; method=:akima)::Array
    if method == :akima
        return gradient_akima(x, y)
    else
        return gradient_linear(x, y)
    end
end

function gradient_akima(x::Vector, y::Matrix)::Matrix
    n = size(y)[2]
    dydx = zeros(size(y))
    for i = 1:n
        dydx[:, i] = gradient_akima(x, y[:, i])
    end
    return dydx
end
function gradient_akima(x::Vector, y::Vector)::Vector
    spline = Akima(x, y)
    return FLOWMath.gradient(spline, x)
end

function gradient_linear(x::Vector, y::Matrix)::Matrix
    n = size(y)[2]
    dydx = zeros(size(y))
    for i = 1:n
        dydx[:, i] = FLOWMath.gradient(x, y[:, i], x)
    end
    return dydx
end
function gradient_linear(x::Vector, y::Vector)::Vector
    return FLOWMath.gradient(x, y, x)
end


end # module Gradient
