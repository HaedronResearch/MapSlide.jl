
"""
$(TYPEDSIGNATURES)
Padding-rolling map over array (in-place).
The lag `τ` is `w-1`.
Padding is applied over the first `τ` elements and the rest is rolling mapped.
"""
function mappadroll!(fn::Function, destₜ::AbstractVector{W}, Xₜ::AbstractArray{T}, w::Integer, val::M=missing) where {W, T, M}
	nout = size(Xₜ, SLIDEDIM)
	fill!(selectouterdim(destₜ, 1:w-1), val)
	maproll!(fn, selectouterdim(destₜ, w:nout), Xₜ, w)
	destₜ
end

"""
$(TYPEDSIGNATURES)
Padding-rolling map over Real array.
Uses `T` as the eltype of the output vector.
The lag `τ` is `w-1`.
Padding is applied over the first `τ` elements and the rest is rolling mapped.
"""
function mappadroll(fn::Function, Xₜ::AbstractArray{T}, w::Integer, val::M=missing) where {T<:Real, M}
	nout = size(Xₜ, SLIDEDIM)
	mappadroll!(fn, similar(Xₜ, Union{T, M}, nout), Xₜ, w, val)
end

"""
$(TYPEDSIGNATURES)
Padding-rolling map over array.
Infers the eltype of the output vector from a comprehension (not necessarily Any).
The lag `τ` is `w-1`.
Padding is applied over the first `τ` elements and the rest is rolling mapped.
"""
function mappadrollany(fn::Function, Xₜ::AbstractArray{T}, w::Integer, val::M=missing) where {T, M}
	padding = fill!(similar(Xₜ, Union{T, M}, w-1), val)
	@views vcat(padding, maprollany(fn, Xₜ, w))
end

