# MapSlide.jl

This package lets you map a function over sliding window slices.
A fork of [RollingFunctions.jl](https://github.com/JeffreySarnoff/RollingFunctions.jl).
This package is a WIP.

## Differences to RollingFunctions.jl
* Functions are named like this `map{slide}` (where slide can be `ex`, `roll`, etc) to follow Julia Base conventions
* `map{slide}` functions work with `AbstractArray` not just `AbstractVector`
* No multi vector methods, use an `AbstractArray` to operate over multiple vectors
* No wrappers such as `maproll(mean, ...)`
* Currently no weighted map slides
* AccurateArithmetic was removed

## Available Slides
### Expanding `ex`
Maps function to expanding slice from current index to the beginning.

### Rolling `roll`
Maps function to fixed width moving windows.
This operation truncates by `τ-1`, where `τ` is the lag / window size.

### Expanding-Rolling `exroll`
Expanding window for the first `τ-1` elements (to prevent truncation), rolling window thereafter.

### Padding-Rolling `padroll`
Constant padding for the first `τ-1` elements (to prevent truncation), rolling window thereafter.

## Notes
Use the `map{slide}any` to infer the output eltype from the function output instead of using the input array eltype.
Use `map{slide}!` (in-place version) if you want to set the output eltype manually.
The roll dimension was hardcoded to the first dimension to avoid [type instability with selectdim](https://discourse.julialang.org/t/why-selectdim-is-type-instable/25271).

### Performance Notes
Experiment with `map{slide}{!,any}` variations to see if better performance can be found.
Make sure your map function does not introduce type instability.
Please open an issue if you see a potential performance improvement or pitfall.

This package is aimed to be relatively simple, flexible, generic, and readable while avoiding major performance pitfalls.
For very fast execution of common statistical functions you should look elsewhere, there is a lot of great work in that area.
In particular `ex` can get very slow for large arrays, mapping across moving slices is powerful but it can be unnecessary/inneficient for certain kinds of operations.

## Future Work
Might add `ewm` for exponentially weighted moving map.

## Related
* [RollingFunctions.jl](https://github.com/JeffreySarnoff/RollingFunctions.jl)
* The `mapwindow` function from [ImageFiltering](https://github.com/JuliaImages/ImageFiltering.jl)
* The `slidingwindow` function from [MLDataPattern](https://github.com/JuliaML/MLDataPattern.jl) produces a moving window view
* Fast statistical functions over time: [MaxMinFilters.jl](https://github.com/sairus7/MaxMinFilters.jl), [SortFilters](https://github.com/sairus7/SortFilters.jl)

### Thanks
* [Jeffrey Sarnoff](https://github.com/JeffreySarnoff)
