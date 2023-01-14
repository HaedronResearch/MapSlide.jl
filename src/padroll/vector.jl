
"""
$(TYPEDSIGNATURES)
Padding-rolling map over vector (in-place).
The lag `τ` is `w-1`.
Padding is applied over the first `τ` elements and the rest is rolling mapped.
"""
function mappadroll!(fn::Function, destₜ::AbstractVector{W}, xₜ::AbstractVector{T}, w::Integer, val::M=missing) where {W, T, M}
	@views begin
		fill!(destₜ[1:w-1], val)
		maproll!(fn, destₜ[w:end], xₜ, w)
	end
	destₜ
end

"""
$(TYPEDSIGNATURES)
Padding-rolling map over Real vector.
Uses `T` as the eltype of the output vector.
The lag `τ` is `w-1`.
Padding is applied over the first `τ` elements and the rest is rolling mapped.
"""
function mappadroll(fn::Function, xₜ::AbstractVector{T}, w::Integer, val::M=missing) where {T<:Real, M}
	mappadroll!(fn, similar(xₜ, Union{T, M}), xₜ, w, val)
end

