@def title = "Analyze mathematical functions interactively"
@def rss = "An alternative way to do common math exercises."
@def rss_pubdate = Date(2020, 6, 24)
@def published = "June 24, 2020"

Finding function's roots, derivatives, maxima and minima, and similar are common exercises in mathematics.
For simple functions, it's easy to do it on paper.
For more complex ones, not as much.

However, you'd want to check your solution in any case.
A common way to do that is to use a website with the tools for functional analysis
(like Wolfram Alpha), or even better, a more complete software (like Mathematica).

Such software is usually proprietary, so to use its full potential, you have to pay.
Ultimately, students who are financially limited cannot use it.
Another problem is that you cannot use the software for higher-level programming,
which limits your future work.

An alternative way is to use a programming language suited for the job.
One of the modern options is Julia, with common math functions available without imports (`Math.sqrt` needed no more).
Here I'll present a way to do it in Julia's REPL (read-eval-print loop),
which gives you the answers interactively, rather than executing a file with your code.

## Plotting

Before going further with your analysis, it's useful to take a look at the function's graph.
A common way to do that in Julia is with the `Plots` package (`]add Plots` to add it in Julia REPL).

~~~
<div class="alert alert-warning" role="alert">
  Running the Plots package for the first time can be slow.
  That is being continuously improved, though.
</div>
~~~

We'll try to plot this polynomial:
$$ f(x) = x^3 - 6x^2 + 11x - 6 $$

It is as simple as:
```julia-repl
julia> using Plots

julia> f(x) = x^3 - 6x^2 + 11x - 6
f (generic function with 1 method)
julia> plot(f)
```

~~~
<img src="/assets/img/plot-1.png" class="img-fluid" alt="Basic plot">
~~~

## Finding roots

The graph is there, but it isn't really precise, as you can't tell where the roots are exactly.
Looking at it, you may notice they are somewhere in $ [0, 4] $.
To plot on range $ [a, b] $ only, use `plot(f, a, b)`.
It's also useful to put the x-axis, $ y = 0 $ (named `zero` in Julia), on the same graph.

```julia-repl
julia> plot(f, 0, 4)
julia> plot!(zero, 0, 4) # don't forget the range for zero function
```

~~~
<img src="/assets/img/plot-2.png" class="img-fluid" alt="Plot with custom range">
~~~

There are the three roots that the polynomial has.
They obviously are 1, 2 and 3, but let's check it.

Very unexpectedly, there's `Roots` package, too (`]add Roots`).
It requires a range to look for the solutions, but we already have that ($ [0, 4] $).
It turns out our solutions were right:

```julia-repl
julia> using Roots

julia> find_zeros(f, 0, 4)
3-element Array{Float64,1}:
 0.9999999999999999
 2.0
 3.0000000000000004
```

~~~
<div class="alert alert-info" role="alert">
  Roots has a better-equipped function <code>find_zero</code>, but it cannot find multiple zeros at once.
</div>
~~~

## Derivatives

The third and the last package for today is `Calculus` (don't forget to add it).
It has a simple interface for differentiating a function.

We suspect that derivative is close to zero around 1.4 (local extremum)
and that second derivative is close to zero around 2.0 (inflection point).

```julia-repl
julia> using Calculus

julia> derivative(f, 1.4)
0.08000000003876237
julia> second_derivative(f)(2.0)
-1.9021615881580974e-6
```

(`second_derivative` has to be used this way, for technical reasons.)

Let's plot the derivative, to combine all the ideas from this post:

```
julia> plot(derivative(f), 0, 4)

julia> plot!(zero, 0, 4)
```

~~~
<img src="/assets/img/plot-3.png" class="img-fluid" alt="Derivative's plot with custom range">
~~~

## Symbolic differentiation

Perhaps you want not only to check your derivative numerically, but also symbolically.
For example, you may want to check is $ \frac{d}{dx} (e^x + x^2) = e^x + 2x $.
That involves a bit more work.

First, it is more convenient to define your function as a symbolic expression.
You do that by adding `:()` around the expression:

```julia-repl
julia> f = :(e^x + x^2)
```

Now using `Calculus`, you can get a symbolic expression for the derivative:
```julia-repl
julia> (differentiate(f))
:(e ^ x * ((0x) / e + 1 * log(e)) + 2 * 1 * x ^ (2 - 1))
```

Neat, isn't it? (No, it isn't.)
You can make it more neat using `simplify` and `deparse`, also provided by `Calculus`:
```
julia> simplify(ans)
:(e ^ x * log(e) + 2x)
julia> deparse(ans)
"e ^ x * log(e) + 2 * x"
```
`ans` represents the answer of the previous input, just like on your pocket calculator.
It still isn't perfect, as there is an unnecessary factor `log(e)` (equal to 1).

## Further reading

Documentation sites for the packages used in this post are very useful.
There is also [Calculus with Julia](https://calculuswithjulia.github.io/),
a nice explanation for doing anything mathematical from $ 2 + 2 $ up to triple integrals.
