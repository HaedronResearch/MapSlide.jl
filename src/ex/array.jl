
"""
$(TYPEDSIGNATURES)
Expanding map over array (in-place).
The function is mapped over all values from the first to current index for all indices.
"""
function mapex!(fn::Function, destₜ::AbstractVector{W}, Xₜ::AbstractArray{T}) where {W, T}
	@inbounds for t in eachindex(destₜ)
		destₜ[t] = fn(selectdim(Xₜ, 1:t))
	end
	destₜ
end

"""
$(TYPEDSIGNATURES)
Expanding map over Real array.
Uses `T` as the eltype of the output vector.
The function is mapped over all values from the first to current index for all indices.
"""
function mapex(fn::Function, Xₜ::AbstractArray{T}) where {T<:Real}
	nout = size(Xₜ, SLIDEDIM)
	mapex!(fn, similar(Xₜ, nout), Xₜ)
end

"""
$(TYPEDSIGNATURES)
Expanding map over array.
Infers the eltype of the output vector from a comprehension (not necessarily Any).
The function is mapped over all values from the first to current index for all indices.
"""
function mapexany(fn::Function, Xₜ::AbstractArray{T}) where {T}
	nout = size(Xₜ, SLIDEDIM)
	[fn(selectdim(Xₜ, 1:t)) for t in 1:nout]
end

