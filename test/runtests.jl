using MapSlide
using Test

let # vector tests
	l = 10
	xₜ = ones(l)
	for w in [3]
		@test mapex(sum, xₜ) == collect(1:l)
		@test maproll(sum, xₜ, w) == fill(w, l-w+1)
		@test mapexroll(sum, xₜ, w) == [1:w-1..., fill(w, l-w+1)...]
		@test mappadroll(sum, xₜ, w, 0) == vcat(fill(0,w-1), fill(w, l-w+1))
		padrollout = mappadroll(sum, xₜ, w, missing)
		@test all(ismissing, padrollout[1:w-1]) && padrollout[w:end] == fill(w, l-w+1)
	end
end

# let # array tests TODO
# end

