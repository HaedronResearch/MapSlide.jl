
"""
$(TYPEDSIGNATURES)
Expanding-rolling map over array (in-place).
The function is expanding mapped over the first `τ-1` elements and rolling mapped over the rest.
"""
function mapexroll!(fn::Function, destₜ::AbstractVector{W}, Xₜ::AbstractArray{T}, τ::Integer) where {W, T}
	nout = size(Xₜ, SLIDEDIM)
	mapex!(fn, selectouterdim(destₜ, 1:τ-1), Xₜ)
	maproll!(fn, selectouterdim(destₜ, τ:nout), Xₜ, τ)
	destₜ
end

"""
$(TYPEDSIGNATURES)
Expanding-rolling map over Real array.
Uses `T` as the eltype of the output vector.
The function is expanding mapped over the first `τ-1` elements and rolling mapped over the rest.
"""
function mapexroll(fn::Function, Xₜ::AbstractArray{T}, τ::Integer) where {T<:Real}
	nout = size(Xₜ, SLIDEDIM)
	mapexroll!(fn, similar(Xₜ, nout), Xₜ, τ)
end

"""
$(TYPEDSIGNATURES)
Expanding-rolling map over array.
Infers the eltype of the output vector from a comprehension (not necessarily Any).
The function is expanding mapped over the first `τ-1` elements and rolling mapped over the rest.
"""
function mapexrollany(fn::Function, Xₜ::AbstractArray{T}, τ::Integer) where {T}
	@views vcat(mapexany(fn, Xₜ[1:τ-1]), maprollany(fn, Xₜ, τ))
end

