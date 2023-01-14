
"""
$(TYPEDSIGNATURES)
Expanding-rolling map over vector (in-place).
The lag `τ` is `w-1`.
The function is expanding mapped over the first `τ` elements and rolling mapped over the rest.
"""
function mapexroll!(fn::Function, destₜ::AbstractVector{W}, xₜ::AbstractVector{T}, w::Integer) where {W, T}
	@views begin
		mapex!(fn, destₜ[1:w-1], xₜ)
		maproll!(fn, destₜ[w:end], xₜ, w)
	end
	destₜ
end

"""
$(TYPEDSIGNATURES)
Expanding-rolling map over Real vector.
Uses `T` as the eltype of the output vector.
The lag `τ` is `w-1`.
The function is expanding mapped over the first `τ` elements and rolling mapped over the rest.
"""
function mapexroll(fn::Function, xₜ::AbstractVector{T}, w::Integer) where {T<:Real}
	mapexroll!(fn, similar(xₜ), xₜ, w)
end

