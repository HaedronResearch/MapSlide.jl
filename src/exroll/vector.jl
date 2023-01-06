
"""
$(TYPEDSIGNATURES)
Expanding-rolling map over vector (in-place).
The function is expanding mapped over the first `τ-1` elements and rolling mapped over the rest.
"""
function mapexroll!(fn::Function, destₜ::AbstractVector{W}, xₜ::AbstractVector{T}, τ::Integer) where {W, T}
	@views begin
		mapex!(fn, destₜ[1:τ-1], xₜ)
		maproll!(fn, destₜ[τ:end], xₜ, τ)
	end
	destₜ
end

"""
$(TYPEDSIGNATURES)
Expanding-rolling map over Real vector.
Uses `T` as the eltype of the output vector.
The function is expanding mapped over the first `τ-1` elements and rolling mapped over the rest.
"""
function mapexroll(fn::Function, xₜ::AbstractVector{T}, τ::Integer) where {T<:Real}
	mapexroll!(fn, similar(xₜ), xₜ, τ)
end

