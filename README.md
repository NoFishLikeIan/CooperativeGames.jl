# CooperativeGames.jl

A package to initiate and apply various solution methods to cooperative transferable utility games.

### Definitions 

A cooperative game is composed by a set of players N and a function v, measure of the powerset of N.

### Initiate a Game

A game can be initiated with, 

```julia
one, two, three = [1], [2], [3]
N = one ∪ two ∪ three

v(S::Int) = v([S])
function v(S::Players)
  if isempty(S) return 0. end
  # Mapping from S subset of N onto R
end

G = Game(N, v)
```

and can be tested for convexity as

```julia
isconvex(G) # false
```

Monotonicity and core algorithm coming up!

### Solutions

One can compute the Harsanyi dividend for a coalition with 

```julia
S = [1, 3]

Δₕ(G, S)
```

and the Shapley value using

```julia
fₛ(G) # Permutation solution

[fₛⁱ(G, i) for i in G.N] # With Harsanyi dividends

```

