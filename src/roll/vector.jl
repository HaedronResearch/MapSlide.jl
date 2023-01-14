
"""
$(TYPEDSIGNATURES)
Rolling map over vector (in-place).
The function is mapped over each window `w` of values for each index (includes current index).
The lag `τ` is `w-1`. The output is `τ` shorter than the input.
"""
function maproll!(fn::Function, destₜ::AbstractVector{W}, xₜ::AbstractVector{T}, w::Integer) where {W, T}
	τ = w - 1
	@inbounds for t in eachindex(destₜ)
		destₜ[t] = fn(@view xₜ[t:t+τ])
	end
	destₜ
end

"""
$(TYPEDSIGNATURES)
Rolling map over Real vector.
Uses `T` as the eltype of the output vector.
The function is mapped over each window `w` of values for each index (includes current index).
The lag `τ` is `w-1`. The output is `τ` shorter than the input.
"""
function maproll(fn::Function, xₜ::AbstractVector{T}, w::Integer) where {T<:Real}
	nout = rollsize(length(xₜ), w)
	maproll!(fn, similar(xₜ, nout), xₜ, w)
end

