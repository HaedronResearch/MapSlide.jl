module MapSlide

#using Base: @kwdef

export mapex!, mapex, mapexany
export maproll!, maproll, maprollany
export mapexroll!, mapexroll, mapexrollany
export mappadroll!, mappadroll, mappadrollany
# export mapew, mapewany

using DocStringExtensions: TYPEDSIGNATURES
# using LinearAlgebra: normalize
# using StatsBase: AbstractWeights, Weights, FrequencyWeights, AnalyticWeights, ProbabilityWeights
# using KahanSummation: sum_kbn
# using AccurateArithmetic: sum_oro
using LoopVectorization

const SLIDEDIM = 1
const Sequence = Union{Vec, Tup} where {N, T, Vec<:AbstractVector{T}, Tup<:NTuple{N,T}}

include("util.jl")
for slide in ("ex", "roll", "exroll", "padroll"), target in ("vector", "array")
	include(joinpath(slide, target*".jl"))
end

end

