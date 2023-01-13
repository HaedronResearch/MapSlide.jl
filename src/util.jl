
"""
$(TYPEDSIGNATURES)
Select slice at first dim.
"""
@inline selectouterdim(A::AbstractArray{T, 1}, i) where {T} = @view A[i]
@inline selectouterdim(A::AbstractArray{T, 2}, i) where {T} = @view A[i, :]
@inline selectouterdim(A::AbstractArray{T, 3}, i) where {T} = @view A[i, :, :]
@inline selectouterdim(A::AbstractArray{T, 4}, i) where {T} = @view A[i, :, :, :]
@inline selectouterdim(A::AbstractArray{T, 5}, i) where {T} = @view A[i, :, :, :, :]
@inline selectouterdim(A::AbstractArray, i) = selectdim(A, SLIDEDIM, i)

# """
# Slices the outer (first) dimension, and leaves the rest intact.
# Unlike `Base.selectdim` this function is not type unstable.
# """
# @inline function selectouterdim(arr::AbstractArray, i)
# 	@view arr[i, fill(:, ndims(arr)-1)...]
# end

# """
# $(TYPEDSIGNATURES)
# """
# function fills(filler::T, xₜ::AbstractVector{T}) where {T}
# 	nvals = axes(xₜ)[1].stop
# 	fill(filler, nvals)
# end

# """
# $(TYPEDSIGNATURES)
# """
# function fills(filler::T1, xₜ::AbstractVector{T2}) where {T1, T2}
# 	elemtype = Union{T1,T2}
# 	nvals  = axes(xₜ)[1].stop
# 	result = Array{elemtype,1}(undef, nvals)
# 	result[:] = filler
# 	result
# end

"""
$(TYPEDSIGNATURES)
Length of output after rolling operation with length `n` and window `τ`.
"""
function rollsize(n::T, τ::T) where {T<:Signed}
	(0 < τ <= n) || throw(SpanError(n, τ))
	n - τ + 1
end

# """
# $(TYPEDSIGNATURES)
# Number of values to be imputed
# """
# function nfilled(τ::T) where {T<:Signed}
# 	τ < 1 && throw(SpanError(n, τ))
# 	τ - 1
# end

SpanError(n, τ) = ErrorException("\n\tBad window ($τ) for length $n.\n" )

# WeightsError(nweighting, τ) =
# 	ErrorException("\n\tτ ($τ) != length(weighting) ($nweighting))).\n" )
