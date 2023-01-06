
"""
$(TYPEDSIGNATURES)
Rolling map over array (in-place).
The function is mapped over the previous `τ` values for each index (includes current index).
This map slide will produce an output that is `τ-1` shorter than the input.
"""
function maproll!(fn::Function, destₜ::AbstractVector{W}, Xₜ::AbstractArray{T}, τ::Integer) where {W, T}
	offset = τ - 1
	@inbounds for t in eachindex(destₜ)
		destₜ[t] = fn(selectdim(Xₜ, t:t+offset))
	end
	destₜ
end

"""
$(TYPEDSIGNATURES)
Rolling map over Real array.
Uses `T` as the eltype of the output vector.
The function is mapped over the previous `τ` values for each index (includes current index).
This map slide will produce an output that is `τ-1` shorter than the input.
"""
function maproll(fn::Function, Xₜ::AbstractArray{T}, τ::Integer) where {T<:Real}
	nout = rollsize(size(Xₜ, SLIDEDIM), τ)
	maproll!(fn, similar(Xₜ, nout), Xₜ, τ)
end

"""
$(TYPEDSIGNATURES)
Rolling map over array.
Infers the eltype of the output vector from a comprehension (not necessarily Any).
The function is mapped over the previous `τ` values for each index (includes current index).
This map slide will produce an output that is `τ-1` shorter than the input.
"""
function maprollany(fn::Function, Xₜ::AbstractArray{T}, τ::Integer) where {T}
	offset = τ - 1
	nout = rollsize(size(Xₜ, SLIDEDIM), τ)
	[fn(selectdim(Xₜ, t:t+offset)) for t in 1:nout]
end

