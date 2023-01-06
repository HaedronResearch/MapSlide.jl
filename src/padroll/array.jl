
"""
$(TYPEDSIGNATURES)
Padding-rolling map over array (in-place).
Padding is applied over the first `τ-1` elements and the rest is rolling mapped.
"""
function mappadroll!(fn::Function, destₜ::AbstractVector{W}, Xₜ::AbstractArray{T}, τ::Integer, val::M=missing) where {W, T, M}
	nout = size(Xₜ, SLIDEDIM)
	fill!(selectdim(destₜ, 1:τ-1), val)
	maproll!(fn, selectdim(destₜ, τ:nout), Xₜ, τ)
	destₜ
end

"""
$(TYPEDSIGNATURES)
Padding-rolling map over Real array.
Uses `T` as the eltype of the output vector.
Padding is applied over the first `τ-1` elements and the rest is rolling mapped.
"""
function mappadroll(fn::Function, Xₜ::AbstractArray{T}, τ::Integer, val::M=missing) where {T<:Real, M}
	nout = size(Xₜ, SLIDEDIM)
	mappadroll!(fn, similar(Xₜ, Union{T, M}, nout), Xₜ, τ, val)
end

"""
$(TYPEDSIGNATURES)
Padding-rolling map over array.
Infers the eltype of the output vector from a comprehension (not necessarily Any).
Padding is applied over the first `τ-1` elements and the rest is rolling mapped.
"""
function mappadrollany(fn::Function, Xₜ::AbstractArray{T}, τ::Integer, val::M=missing) where {T, M}
	padding = fill!(similar(Xₜ, Union{T, M}, τ-1), val)
	@views vcat(padding, maprollany(fn, Xₜ[τ:end], τ))
end

