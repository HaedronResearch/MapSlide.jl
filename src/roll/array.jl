
"""
$(TYPEDSIGNATURES)
Rolling map over array (in-place).
The function is mapped over each window `w` of values for each index (includes current index).
The lag `τ` is `w-1`. The output is `τ` shorter than the input.
"""
function maproll!(fn::Function, destₜ::AbstractVector{W}, Xₜ::AbstractArray{T}, w::Integer) where {W, T}
	τ = w - 1
	@inbounds for t in eachindex(destₜ)
		destₜ[t] = fn(selectouterdim(Xₜ, t:t+τ))
	end
	destₜ
end

"""
$(TYPEDSIGNATURES)
Rolling map over Real array.
Uses `T` as the eltype of the output vector.
The function is mapped over each window `w` of values for each index (includes current index).
The lag `τ` is `w-1`. The output is `τ` shorter than the input.
"""
function maproll(fn::Function, Xₜ::AbstractArray{T}, w::Integer) where {T<:Real}
	nout = rollsize(size(Xₜ, SLIDEDIM), w)
	maproll!(fn, similar(Xₜ, nout), Xₜ, w)
end

"""
$(TYPEDSIGNATURES)
Rolling map over array.
Infers the eltype of the output vector from a comprehension (not necessarily Any).
The function is mapped over each window `w` of values for each index (includes current index).
The lag `τ` is `w-1`. The output is `τ` shorter than the input.
"""
function maprollany(fn::Function, Xₜ::AbstractArray{T}, w::Integer) where {T}
	τ = w - 1
	nout = rollsize(size(Xₜ, SLIDEDIM), w)
	[fn(selectouterdim(Xₜ, t:t+τ)) for t in 1:nout]
end

