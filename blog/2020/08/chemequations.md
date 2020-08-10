@def title = "New package: ChemEquations.jl"
@def rss = "Write and balance chemical equations elegantly and efficiently."
@def rss_pubdate = Date(2020, 8, 10)
@def published = "August 10, 2020"

There are already many tools for balancing chemical equations,
such as [Balance Chemical Equation](https://www.webqc.org/balance.php) at webqc.org.
They do a great job, but they have several limitations.
Internet connection is required to use them,
while it's impossible to obtain the results programmatically, via an API.
Support for custom input is also limited.

That's why I wanted to build a Julia package for writing and balancing chemical equations.
Named **ChemEquations.jl**, it's a seemingly simple tool, yet useful for more complicated work.
You can install the package by pressing `]` in Julia REPL and typing:
```
add ChemEquations
```

It's available on [GitHub](https://github.com/zdroid/ChemEquations.jl).
If you want to see the documentation, just click a button:
[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://zdroid.github.io/ChemEquations.jl/stable/)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://zdroid.github.io/ChemEquations.jl/dev/).

## Textbook examples

Equations can be written conveniently, with various forms supported.
The easiest way to write them is as strings with `ce` prefix (**c**hemical **e**quation),
similar to `r` prefix for regex in Julia.

```julia-repl
julia> equation = ce"Fe + Cl2 = FeCl3"
Fe + Cl2 = FeCl3

julia> balance(equation)
2 Fe + 3 Cl2 = 2 FeCl3
```

Parsing the input is insensitive to whitespace and to state symbols (`(s)`, `(l)`, `(g)`, `(aq)`),
so you don't have to be pedantic if you don't want to.

```julia-repl
julia> balance(ce"KMnO4+ HCl = KCl+MnCl2 +H2O + Cl2")
2 KMnO4 + 16 HCl = 2 KCl + 2 MnCl2 + 8 H2O + 5 Cl2

julia> balance(ce"Zn(s) + O2(g) = ZnO(s)")
2 Zn + O2 = 2 ZnO
```

Parentheses (`()`), compounds written with `*` and electrical charges are all supported.
Electron will be recognized if you write `e`, `{-}`, `{-1}` or `{1-}`.
Charge is also supposed to be in any of those forms.

```julia-repl
julia> balance(ce"K4Fe(CN)6 + H2SO4 + H2O = K2SO4 + FeSO4 + (NH4)2SO4 + CO")
K4FeC6N6 + 6 H2SO4 + 6 H2O = 2 K2SO4 + FeSO4 + 3 N2H8SO4 + 6 CO

julia> balance(ce"Cr2O7{-2} + H{+} + {-} = Cr{+3} + H2O")
Cr2O7{-2} + 14 H{+} + 6 e = 2 Cr{+3} + 7 H2O

julia> balance(ce"CuSO4*5H2O = CuSO4 + H2O")
CuSO9H10 = CuSO4 + 5 H2O
```

Even the hardest exercises are in the reach:
```julia-repl
julia> balance(ce"K4Fe(CN)6 + KMnO4 + H2SO4 = KHSO4 + Fe2(SO4)3 + MnSO4 + HNO3 + CO2 + H2O")
10 K4FeC6N6 + 122 KMnO4 + 299 H2SO4 = 162 KHSO4 + 5 Fe2S3O12 + 122 MnSO4 + 60 HNO3 + 60 CO2 + 188 H2O
```

## How is it different

Parsing doesn't stop at chemical equations.
The package also supports writing compounds, independent of an equation.
The syntax is similar, just with `cc` prefix (**c**hemical **c**ompound) instead of `ce`.

```julia-repl
julia> cc"CuSO4*5H2O"
CuSO9H10

julia> cc"H3O{+1}"
H3O{+}
```

You can compare two compounds written in different forms:
```julia-repl
julia> cc"CH3CH2CH2CH2CH2OH" == cc"C5H12O"
true
```

Using a different equals sign (e.g. `⟺`, `≔`, `⟼`, `⟻`) is also possible:
```julia-repl
julia> ce"N2+O2⇌2NO"
N2 + O2 = 2 NO

julia> ce"H2 + O2 → H2O"
H2 + O2 = H2O
```

Are two chemical equations identical? Let's find out:
```julia-repl
julia> ce"CH3CH2OH + O2 = CO2 + HOH" == ce"C2H5OH + O2 → H2O + CO2"
true
```

~~~
<div class="alert alert-info" role="alert">
  The syntax flexibility comes at no additional costs.
</div>
~~~

## Using unicode characters

All unicode characters that are letters (such as α and β) or symbols (such as × and ÷) are supported in the input.
That allows some exotic examples:
```julia-repl
julia> ce"Σ{+1} + Θ{-1} = Θ2 + Σ2"
Σ{+} + Θ{-} = Θ2 + Σ2
```

This works because compounds are parsed by elements, where an element begins with an uppercase unicode letter and
ends with a lowercase unicode letter or a unicode symbol.

~~~
<div class="alert alert-info" role="alert">
  An element can also begin with a symbol if
    the symbol is the first character (e.g. <code>"⬡H"</code>).
</div>
~~~

It's even more interesting to use unicode symbols that resemble chemical symbols.
Examples of those are ⎔ (`\hexagon`), ⬡ (`varhexagon`), ⬢ (`\varhexagonblack`), ⌬ (`\varhexagonlrbonds`) and ⏣ (`\benzenr`).

Unicode input allows writing some equations very nicely:
```julia-repl
julia> ce"⏣H + Cl2 = ⏣Cl + HCl"
⏣H + Cl2 = ⏣Cl + HCl

julia> ce"C + α = O + γ" # a reaction from triple-α process
C + α = O + γ
```

## Non-integer coefficients

Sometimes coefficients in a chemical equation are written as fractions or decimals.

To initialize such equation, you need to specify the appropriate Julia type for the coefficients.
`Rational` or `Rational{Int}` is appropriate for exact fractions, while `Float64` is appropriate for decimals.
```julia-repl
julia> ChemEquation{Rational}("1//2 H2 + 1//2 Cl2 → HCl")
1//2 H2 + 1//2 Cl2 = HCl

julia> ChemEquation{Float64}("0.5 H2 + 0.5 Cl2 = HCl")
0.5 H2 + 0.5 Cl2 = HCl
```
Previous two examples are equivalent (test it with `==`!), thanks to the way that numbers are stored in Julia.

You can also initialize the equation normally:
```julia-repl
julia> eq = ce"H2 + Cl2 → HCl"
H2 + Cl2 = HCl
```

and then choose to balance it with rational fractions as coefficients:
```julia-repl
julia> balance(eq, fractions=true)
1//2 H2 + 1//2 Cl2 = HCl
```

## Behind the scenes

A chemical equation is stored as `ChemEquation` struct,
which just contains a vector of tuples that represent the compounds and their coefficients.
A `Compound` is also a struct, but it contains charge and
a vector of tuples that represent the elements and their coefficients.
You can explore the internals of those structures further with Julia's `dump`.

There are helper functions that operate on those structs,
such as `hascharge`, `elements` and `compounds`,
whose use you can guess by their name (try them!).

Balancing the equations is based on
[Thorne (2009)](https://arxiv.org/ftp/arxiv/papers/1110/1110.4321.pdf), with slight modifications.
The paper suggests constructing an equation matrix and then balancing it using the nullspace method.

In an equation matrix, rows correspond to atoms and columns correspond to compounds.
`equationmatrix` method calculates it:
```julia-repl
julia> equationmatrix(ce"H2 + Cl2 → HCl")
2×3 Array{Int64,2}:
 2  0  1
 0  2  1
```

It is then used by `balancematrix` to obtain the balanced coefficients exactly:
```
julia> balancematrix(ce"H2 + Cl2 → HCl")
3×1 Array{Rational{BigInt},2}:
  1//1
  1//1
 -2//1
```
[LinearAlgebraX](https://github.com/scheinerman/LinearAlgebraX.jl) is used for that,
as it gives exact solutions for integers and rationals.
The result is a matrix which represents the nullspace of the system.
It is further analyzed:

1. If the matrix has no rows, there are no solutions.
2. If there is only one row, there is a unique solution.
3. If there is more than one row, the equation can be balanced in infinitely many ways.
   This usually happens if the equation is a combination of two different equations.

And then the results are constructed into a `ChemEquation` with `balance` method.

## What's planned for the future

- stoichiometric calculations
- customization of the display format
- integration with [Catalyst.jl](https://github.com/SciML/Catalyst.jl) and
  [Latexify.jl](https://github.com/korsbo/Latexify.jl)

Have any ideas? [Open an issue](https://github.com/zdroid/ChemEquations.jl/issues), or contact me directly!
