@def title = "Make your Julia package in 10 minutes"
@def rss = "Making a package can be a hassle, but in Julia it doesn't have to be so."
@def rss_pubdate = Date(2020, 6, 13)
@def published = "June 13, 2020"

Making a package can be a hassle, but in Julia it doesn't have to be so.
There are some great tools which can help you achieve this task in less than 10 minutes.

Suppose you came up with the formula to calculate n-th term of the famed Fibonacci series.
Using $ {\varphi = \frac{1 + \sqrt{5}}{2}} $, it turned out to be:
$$ \frac{\varphi^n - (-\varphi)^{-n}}{\sqrt{5}} $$

You want to share it with the world.
You know Julia's syntax, but not how to turn your function into a package.

## Using a template

First, you need a package template. In Julia REPL, type `]` and then `add PkgTemplates`.
It will install the package that provides you with templates.

It also requires you to have `user.name`, `user.email` and `github.user` set in `.gitconfig`.
If those are missing, you can add them like `git config --global user.name "username"`, executed in your shell.

Now you can make your own package "Fibonacci" based on a simple template. In Julia REPL:
```julia
julia> using PkgTemplates
julia> t = Template()
julia> t("Fibonacci")
```
Voila! Your package is in `~/.julia/dev/Fibonacci` (the default location).
Navigate to it.
You can see the metafiles like `Project.toml`, `.gitignore`, `LICENSE` and `README.md` already created.

## Adding your function

Now onto the fibonacci function.
`src/Fibonacci.jl` is the main file of your package and it looks like this:
```julia
module Fibonacci

# Write your package code here.

end
```

`module Fibonacci` indicates your package has its own scope.
You want to add `fibonacci` function into that scope, like this:
```julia
module Fibonacci

# Write your package code here.

export fibonacci

function fibonacci(n)
    φ = (1 + √5) / 2
    return round((φ^n - (-φ)^-n) / √5)
end

end
```
`export fibonacci` indicates you want the function to be accessible outside the module.
The exports are usually grouped on top of the module (even before the functions were declared).
The reasons for that are idiomatic, as in larger module you'll have imports, exports and includes on top of the file.
Anyone looking at the code could easily tell what is imported and exported in the module.

## Using the function

Your package needs to be activated first, so that you can use it.
Type `]` and then `activate .` (the current directory).

Now you can include the function from your package (`using Fibonacci`) and use it:
```julia
julia> using Fibonacci

julia> fibonacci(20)
6765.0
```

## Adding tests

It's a good practice to make sure your code works by adding tests.
Test file is already conveniently created as `test/runtests.jl`.
Tests are scoped inside `@testset`s and have a `@test condition` syntax.
Let's add a few tests:
```julia
using Fibonacci
using Test

@testset "Fibonacci.jl" begin
    # Write your tests here.

    # Here are the tests:
    @test fibonacci(0) == 0
    @test fibonacci(3) == 2
    @test fibonacci(5) == 5
end
```

Running tests is as easy as typing `]` and then `test` (assuming you have already done `]activate .`).
If the tests were successful, you'll get the following message:
```
Test Summary: | Pass  Total
Fibonacci.jl  |    3      3
    Testing Fibonacci tests passed
```

## Adding dependencies

This is an optional section, since your package and its tests are already done.

As the package grows, you'll want to use some other packages to help you build your package.
Those are called dependencies and you add them by typing `]` and then `add PackageName`.
You have to make sure you did `]activate .` first (like in the previous section).
`Project.toml` and `Manifest.toml` will be updated automatically after adding your dependencies,
so you shouldn't edit them for this purpose.

Let's add `Combinatorics`, which already has a Fibonacci function named `fibonaccinum`.
After adding it, you can use `fibonaccinum` in `src/Fibonacci.jl` (don't forget `using Combinatorics`):

```julia
module Fibonacci

# Write your package code here.

using Combinatorics

export fibonacci, anotherfibonacci

function fibonacci(n)
    φ = (1 + √5) / 2
    return round((φ^n - (-φ)^-n) / √5)
end

function anotherfibonacci(n)
    return fibonaccinum(n)
end

end
```

## Final word

This is a very simplified version of the process, since it's done with a template.
However, using a template lets you worry not about all the specifics, but about the actual code only.

You should definitely try adding more functions to your package, or building another one.
Additional template options are explained in [PkgTemplates readme](https://github.com/invenia/PkgTemplates.jl#readme) and [its documentation](https://invenia.github.io/PkgTemplates.jl/).

If you get stuck, you can always post a question on [Julia Discourse](https://discourse.julialang.org/) or [Slack](https://julialang.slack.com/).

~~~
<div class="alert alert-warning" role="alert">
  Note: writing a blog post about making a Julia package takes more than 10 minutes.
</div>
~~~
