### A Pluto.jl notebook ###
# v0.12.21

using Markdown
using InteractiveUtils

# ╔═╡ 89afbcb4-8e34-11eb-2b4a-6de17ac9f445
using CooperativeGames, IterTools

# ╔═╡ 7f678a3e-8e34-11eb-1d82-45f4bcd5a934
md"""
# Simple game

Let's consider a simple game with three players, $N = \{1, 2, 3\}$ and a value function $v$ constracted as following,

$v(\{1\}) = 1$
$v(\{1, 2\}) = v(\{1, 3\}) = 3$
$v(\{2\}) = v(\{2, 3\}) = 2$
$v(N) = 4$
"""

# ╔═╡ 64da83d8-8e34-11eb-3ec0-230c96512e18
begin
    one, two, three = [1], [2], [3]
    N = one ∪ two ∪ three
	
	v(S) = v([S]) # v(1) -> v({1})
	function v(S::Players)
    	S = sort(S)
    	if S == N 4
    	elseif S == one 1
        elseif S == two 2
        elseif S == three 0
        elseif S == one ∪ two 3
        elseif S == one ∪ three 3
        elseif S == two ∪ three 2
        elseif isempty(S) 0 end 
	end
	
end

# ╔═╡ a760c7ca-8e35-11eb-1969-99389134ae90
md"""The package allows us to construct a simple game `SimpleGame` that implements many common methods"""

# ╔═╡ 1b988052-8e35-11eb-19ba-1768b62b33af
G = SimpleGame(N, v); G.v(G.N)

# ╔═╡ c0d8f036-8e35-11eb-2d0c-5b8356fb3952
md"""The first thing that we would like to see is whether the game is **convex**. We can simply do `isconvex(G)`"""

# ╔═╡ ef2b6786-8e35-11eb-051d-414557af32a5
isconvex(G)

# ╔═╡ f6a230d0-8e35-11eb-0414-578b40313277
md"""
## Solutions...

...are the 🍞 and 🧈 of cooperative games. A solution is simply a vector of numbers with $|N|$ entries which assigns a "value" to each player based on $v$.

The package implements many solutions methods, here we can focus on three common ones.
"""

# ╔═╡ 5d386468-8e36-11eb-05bf-53f08045704e
md"""

The first one is the [Harsanyi dividend](https://en.wikipedia.org/wiki/Cooperative_game_theory#Harsanyi_dividend) of a coalition. Implemented with `Δₕ(G::SimpleGame, S::Players)`.

"""

# ╔═╡ 774e1b22-8e36-11eb-3807-fdb05be7536b
begin
	whole = Δₕ(G, G.N) 
	onethree = Δₕ(G, [1, 3])
	
	"Δ$(G.N) = $whole, Δ[1, 3] = $onethree"
end

# ╔═╡ 68f47fe4-8e36-11eb-0163-17e59ab2cf27
md"""A second one is the [Banzhaf value ](https://www.britannica.com/science/game-theory/The-von-Neumann-Morgenstern-theory#ref891942), implemented as, `fᵦⁱ(G::Game, i::Int)`."""

# ╔═╡ 2da1430e-8e37-11eb-076f-a34e0214ad2c
Dict(i => fᵦⁱ(G, i) for i in G.N)

# ╔═╡ 5a4e61a4-8e37-11eb-3aee-4310b4713ff2
md"""
Last, and most importantly, the [Shapley value](https://en.wikipedia.org/wiki/Shapley_value) implemented as `fₛ(G::Game)`
"""

# ╔═╡ a1d31bb2-8e37-11eb-38f0-67840dabbf8d
Dict(enumerate(fₛ(G)))

# ╔═╡ c3192424-8e37-11eb-18c0-f9b8d53d50e4


# ╔═╡ Cell order:
# ╠═89afbcb4-8e34-11eb-2b4a-6de17ac9f445
# ╟─7f678a3e-8e34-11eb-1d82-45f4bcd5a934
# ╠═64da83d8-8e34-11eb-3ec0-230c96512e18
# ╟─a760c7ca-8e35-11eb-1969-99389134ae90
# ╠═1b988052-8e35-11eb-19ba-1768b62b33af
# ╟─c0d8f036-8e35-11eb-2d0c-5b8356fb3952
# ╠═ef2b6786-8e35-11eb-051d-414557af32a5
# ╟─f6a230d0-8e35-11eb-0414-578b40313277
# ╟─5d386468-8e36-11eb-05bf-53f08045704e
# ╠═774e1b22-8e36-11eb-3807-fdb05be7536b
# ╟─68f47fe4-8e36-11eb-0163-17e59ab2cf27
# ╠═2da1430e-8e37-11eb-076f-a34e0214ad2c
# ╟─5a4e61a4-8e37-11eb-3aee-4310b4713ff2
# ╠═a1d31bb2-8e37-11eb-38f0-67840dabbf8d
# ╠═c3192424-8e37-11eb-18c0-f9b8d53d50e4
