
"""
$(TYPEDSIGNATURES)
Expanding map over vector (in-place).
The function is mapped over all values from the first to current index for all indices.
"""
function mapex!(fn::Function, destₜ::AbstractVector{W}, xₜ::AbstractVector{T}) where {W, T}
	@inbounds for t in eachindex(destₜ)
		destₜ[t] = fn(@view xₜ[1:t])
	end
	destₜ
end

"""
$(TYPEDSIGNATURES)
Expanding map over Real vector.
Uses `T` as the eltype of the output vector.
The function is mapped over all values from the first to current index for all indices.
"""
function mapex(fn::Function, xₜ::AbstractVector{T}) where {T<:Real}
	mapex!(fn, similar(xₜ), xₜ)
end

