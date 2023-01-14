
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

"""
$(TYPEDSIGNATURES)
Length of output after rolling operation with length `n` and window `w`.
"""
function rollsize(n::T, w::T) where {T<:Signed}
	(0 < w <= n) || throw(SpanError(n, w))
	n - w + 1
end

SpanError(n, w) = ErrorException("\n\tBad window ($w) for length $n.\n" )

