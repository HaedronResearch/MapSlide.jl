
"""
$(TYPEDSIGNATURES)
Padding-rolling map over vector (in-place).
Padding is applied over the first `τ-1` elements and the rest is rolling mapped.
"""
function mappadroll!(fn::Function, destₜ::AbstractVector{W}, xₜ::AbstractVector{T}, τ::Integer, val::M=missing) where {W, T, M}
	@views begin
		fill!(destₜ[1:τ-1], val)
		maproll!(fn, destₜ[τ:end], xₜ, τ)
	end
	destₜ
end

"""
$(TYPEDSIGNATURES)
Padding-rolling map over Real vector.
Uses `T` as the eltype of the output vector.
Padding is applied over the first `τ-1` elements and the rest is rolling mapped.
"""
function mappadroll(fn::Function, xₜ::AbstractVector{T}, τ::Integer, val::M=missing) where {T<:Real, M}
	mappadroll!(fn, similar(xₜ, Union{T, M}), xₜ, τ, val)
end

