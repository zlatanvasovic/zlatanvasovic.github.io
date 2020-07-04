@def title = "Stay inspired while coding with Inspiration.jl"
@def rss = "Clearing your mind after a bug appears can help you resolve it."
@def rss_pubdate = Date(2020, 7, 4)
@def published = "July 4, 2020"

## The problem

No matter how hard you try, during coding you will encounter some error:

```julia-repl
julia> "Random number: " * rand()
ERROR: MethodError: no method matching *(::String, ::Float64)
Closest candidates are:
  *(::Any, ::Any, ::Any, ::Any...) at operators.jl:529
  *(::Bool, ::T) where T<:AbstractFloat at bool.jl:110
  *(::Float64, ::Float64) at float.jl:405
  ...
Stacktrace:
 [1] top-level scope at REPL[21]:1

```

## The solution

Download some inspiration:
```julia-repl
(@v1.4) pkg> add https://github.com/zdroid/Inspiration.jl
```

Use it:

```julia-repl
julia> using Inspiration
```

And then let it help you:

```julia-repl
julia> "Random number: " * rand()
ERROR: MethodError: no method matching *(::String, ::Float64)
Closest candidates are:
  *(::Any, ::Any, ::Any, ::Any...) at operators.jl:529
  *(::Bool, ::T) where T<:AbstractFloat at bool.jl:110
  *(::Float64, ::Float64) at float.jl:405
  ...
Stacktrace:
 [1] top-level scope at REPL[21]:1

julia> inspire()

  The key to success is to focus on goals, not obstacles.

```

So you clear your mind and try a different approach:

```julia-repl
julia> "Random number: $(rand())"
"Random number: 0.8420406851541038"

```

## Improvements

This is just a fun idea I got while coding.
It's no serious business.

Basically, `Inspiration.jl` is a package that displays a random "inspiring quote" from an array of 20 such quotes.
You can see all of them via `inspiring_quotes` array (also exported in `Inspiration.jl`).

Somebody with the know-how could append this message to error logs in Julia REPL,
so that every time an error appears, an inspiring quote appears, too.
Is there some way in which you think this idea can be improved?
[Submit an issue](https://github.com/zdroid/Inspiration.jl/issues/new)!
