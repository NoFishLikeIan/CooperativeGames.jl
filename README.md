# CooperativeGames.jl

A package to initiate and apply various solution methods to [cooperative transferable utility games](https://en.wikipedia.org/wiki/Cooperative_game_theory).

### Install

You can install using

```julia
using Pkg; Pkg.add("CooperativeGames")
```

and load with

```julia
using CooperativeGames
```


### What can you do

*Implements* simple, graph, link, and [river](https://agupubs.onlinelibrary.wiley.com/doi/abs/10.1029/WR005i004p00749) games. 

*Solve* with Harsanyi dividends, Shapley, Myerson, Banhaf value. 

*Test* for core and fairness.

### Getting started

Get started by defining a set of player `N` and a measure on `powerset(N)`, `v`.

```julia
N = [1, 2, 3] 

v(S::Int) = v([S])
function v(S::Players)
  if isempty(S) return 0. end
  # Mapping from S subset of N onto R
end

G = SimpleGame(N, v)
```

If your game has a graph structure, simply do,

```julia
L = [(1, 2), (2, 3)]

G = GraphGame(N, v, L)
```

This implementation relies on `LightGraphs`.
