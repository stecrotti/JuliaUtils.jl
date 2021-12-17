module JuliaUtils

using ForwardDiff

export linearls, predict
export newton

include("LinearLS.jl")
include("newton.jl")

end
