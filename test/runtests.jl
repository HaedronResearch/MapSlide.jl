using MapSlide
using Test

let # vector tests
	l = 10
	xₜ = ones(l)
	for τ in [3]
		@test mapex(sum, xₜ) == collect(1:l)
		@test maproll(sum, xₜ, τ) == fill(τ, l-τ+1)
		@test mapexroll(sum, xₜ, τ) == [1:τ-1..., fill(τ, l-τ+1)...]
		@test mappadroll(sum, xₜ, τ, 0) == vcat(fill(0,τ-1), fill(τ, l-τ+1))
		padrollout = mappadroll(sum, xₜ, τ, missing)
		@test all(ismissing, padrollout[1:τ-1]) && padrollout[τ:end] == fill(τ, l-τ+1)
	end
end

# let # array tests TODO
# end

