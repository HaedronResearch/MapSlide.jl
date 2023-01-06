
"""
$(TYPEDSIGNATURES)
Rolling map over vector (in-place).
The function is mapped over the previous `τ` values for each index (includes current index).
This map slide will produce an output that is `τ-1` shorter than the input.
"""
function maproll!(fn::Function, destₜ::AbstractVector{W}, xₜ::AbstractVector{T}, τ::Integer) where {W, T}
	offset = τ - 1
	@inbounds for t in eachindex(destₜ)
		destₜ[t] = fn(@view xₜ[t:t+offset])
	end
	destₜ
end

"""
$(TYPEDSIGNATURES)
Rolling map over Real vector.
Uses `T` as the eltype of the output vector.
The function is mapped over the previous `τ` values for each index (includes current index).
This map slide will produce an output that is `τ-1` shorter than the input.
"""
function maproll(fn::Function, xₜ::AbstractVector{T}, τ::Integer) where {T<:Real}
	nout = rollsize(length(xₜ), τ)
	maproll!(fn, similar(xₜ, nout), xₜ, τ)
end

