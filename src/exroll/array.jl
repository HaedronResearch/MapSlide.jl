
"""
$(TYPEDSIGNATURES)
Expanding-rolling map over array (in-place).
The lag `τ` is `w-1`.
The function is expanding mapped over the first `τ` elements and rolling mapped over the rest.
"""
function mapexroll!(fn::Function, destₜ::AbstractVector{W}, Xₜ::AbstractArray{T}, w::Integer) where {W, T}
	nout = size(Xₜ, SLIDEDIM)
	mapex!(fn, selectouterdim(destₜ, 1:w-1), Xₜ)
	maproll!(fn, selectouterdim(destₜ, w:nout), Xₜ, w)
	destₜ
end

"""
$(TYPEDSIGNATURES)
Expanding-rolling map over Real array.
Uses `T` as the eltype of the output vector.
The lag `τ` is `w-1`.
The function is expanding mapped over the first `τ` elements and rolling mapped over the rest.
"""
function mapexroll(fn::Function, Xₜ::AbstractArray{T}, w::Integer) where {T<:Real}
	nout = size(Xₜ, SLIDEDIM)
	mapexroll!(fn, similar(Xₜ, nout), Xₜ, w)
end

"""
$(TYPEDSIGNATURES)
Expanding-rolling map over array.
Infers the eltype of the output vector from a comprehension (not necessarily Any).
The lag `τ` is `w-1`.
The function is expanding mapped over the first `τ` elements and rolling mapped over the rest.
"""
function mapexrollany(fn::Function, Xₜ::AbstractArray{T}, w::Integer) where {T}
	@views vcat(mapexany(fn, Xₜ[1:w-1]), maprollany(fn, Xₜ, w))
end

