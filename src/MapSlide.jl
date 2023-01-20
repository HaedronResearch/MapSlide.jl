module MapSlide

export mapex!, mapex, mapexany
export maproll!, maproll, maprollany
export mapexroll!, mapexroll, mapexrollany
export mappadroll!, mappadroll, mappadrollany

using DocStringExtensions: TYPEDSIGNATURES

const SLIDEDIM = 1

include("util.jl")
for slide in ("ex", "roll", "exroll", "padroll"), target in ("vector", "array")
	include(joinpath(slide, target*".jl"))
end

end

