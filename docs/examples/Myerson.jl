### A Pluto.jl notebook ###
# v0.12.21

using Markdown
using InteractiveUtils

# ╔═╡ 21f280b0-8e21-11eb-170e-6165d9074c11
begin
	using Pkg
	
	pkgs = ["LightGraphs", "CooperativeGames", "GraphPlot", "Colors"]
	Pkg.add.(pkgs)
	print("Loaded packages")
end

# ╔═╡ 91859d00-8e20-11eb-265b-e9b975445823
using CooperativeGames, LightGraphs

# ╔═╡ b53dbba2-8e24-11eb-0ffc-35ac25a17542
using GraphPlot, Colors, Random

# ╔═╡ ae80de3e-8e1f-11eb-1822-317ab395eccc
md"""
# Myerson game

Let's consider a Myerson game, namely a cooperative game with some graph structure. 

There are six players, $\{1, 2, \ldots, 6\}$, which are placed on a graph with edges $L$. A coalition gets some value only if both player $1$ and $6$ are in the coalition and the coalition is connected in the graph.

We can use the structure `GraphGame` to initialize the game. 
"""

# ╔═╡ 1d11d2f2-8e22-11eb-1460-5bfedfcca4c8
begin
	N = collect(1:6)
	
	L = [(1, 2), (1, 3), (2, 4), (3, 5), (4, 5), (5, 6)]
	
	v(S::Players) = (1 ∈ S && 6 ∈ S) ? 1 : 0
	
	G = GraphGame(N, v, L)
end

# ╔═╡ 58ae150e-8e23-11eb-1e82-d9099987aeaf
md"""
Let's plot the graph to get an idea of the game... 
"""

# ╔═╡ ed463b7a-8e22-11eb-2c91-9b5338da44f3
gplot(G.g, nodelabel=G.N)

# ╔═╡ d0016cf0-8e23-11eb-30df-698f4a09c518
md"""
## To take into account the graph structure...

...we can transform the `GraphGame` into a `SimpleGame` where the value function `v` is extended to return $0$ if the coalition is not a connected component. This is called the *Myerson game*.

This is implemented with `CooperativeGames.graphtoMyerson`
"""

# ╔═╡ c196361e-8e23-11eb-256d-4d28a6946baa
mG = graphtoMyerson(G)

# ╔═╡ 3db45316-8e24-11eb-288a-4f7b8fd7b412
begin
	conn = [1, 3, 5, 6]
	notconn = [1, 3, 6]
end

# ╔═╡ 794fed74-8e24-11eb-1883-271efc3229e5
md"""One component: v($(join(conn, ','))) = $(mG.v(conn))

Multiple components: v($(join(notconn, ','))) = $(mG.v(notconn))"""

# ╔═╡ 6ecf1438-8e25-11eb-3dce-5b49ddccc952
md"""
## We can then compute the Shapley value of the Myerson game... 

also known as the Myerson value. 

The [Shapley value](https://en.wikipedia.org/wiki/Shapley_value) is implemented as `fₛ(G)`. Let's compute the Shapley value for our game and plot it in the graph.
"""

# ╔═╡ 170fc040-8e26-11eb-1aac-0f1318fd35c3
begin
	shapley = fₛ(mG)
	blues = colormap("Blues", mid=0.75)
	scaledshapley = floor.(Int64, (shapley.+ 0.25) .* 100)
	nodecolors = blues[scaledshapley]
	
	gplot(G.g, nodelabel=G.N, nodefillc=nodecolors)
end

# ╔═╡ ec8ce830-8e29-11eb-183d-775ac97c2a8d
shapley

# ╔═╡ ca03cb8a-8e29-11eb-2b5f-1dd7093dba9b
md"""
The Shapley value rewards the two necessary players $1$ and $6$, but also the player that is required to make the connected component, that is $5$.
"""

# ╔═╡ 434854ac-8e2a-11eb-0ac0-6f3d970ed52f
md"""
## The Harsanyi degree solution...

is another common solution method. The idea is to scale the marginal benefit that a node brings to a coalition by its degree (i.e. the number of edges it has). This is implemented in the package as `degreeHarsanyi(G)`.

As before we can plot it on the graph,
"""

# ╔═╡ a2cda5ee-8e2a-11eb-296e-bf872617c5d8
begin
	harsanyi = degreeHarsanyi(G)
	scaledharsany = floor.(Int64, (harsanyi.+ 0.25) .* 100)
	hnodecolors = blues[scaledharsany]
	
	gplot(G.g, nodelabel=G.N, nodefillc=hnodecolors)
end

# ╔═╡ d8fd487c-8e2a-11eb-1da5-57a83d948bbf
harsanyi

# ╔═╡ e1a1a22a-8e2a-11eb-152a-3b46967f4511
md"""
As opposed to the Shapley value, the Harsanyi degree solution gives further weight to node $5$.

Another nice property is that the reward assigned to $2$ and $4$ is the same as that assigned to $3$ since they are perfect substitutes in connecting $1$ and $6$.
"""

# ╔═╡ f577dbc0-8e2a-11eb-2966-239e9cd074c3
harsanyi[2] + harsanyi[4] ≈ harsanyi[3]

# ╔═╡ 6d02b2f0-8e2b-11eb-1506-731e875d27d1
md"""
## Fairness...

is another important property of a solution. Namely, if I break a node between two edges the damage the two nodes receive should be divided equally. This again can be tested with `isfair(G, (i, j))`.
"""

# ╔═╡ af14e69a-8e2b-11eb-39b6-a9fb50bd20ba
isfair(G, (1, 2))

# ╔═╡ Cell order:
# ╟─21f280b0-8e21-11eb-170e-6165d9074c11
# ╠═91859d00-8e20-11eb-265b-e9b975445823
# ╠═b53dbba2-8e24-11eb-0ffc-35ac25a17542
# ╟─ae80de3e-8e1f-11eb-1822-317ab395eccc
# ╠═1d11d2f2-8e22-11eb-1460-5bfedfcca4c8
# ╟─58ae150e-8e23-11eb-1e82-d9099987aeaf
# ╠═ed463b7a-8e22-11eb-2c91-9b5338da44f3
# ╟─d0016cf0-8e23-11eb-30df-698f4a09c518
# ╠═c196361e-8e23-11eb-256d-4d28a6946baa
# ╠═3db45316-8e24-11eb-288a-4f7b8fd7b412
# ╟─794fed74-8e24-11eb-1883-271efc3229e5
# ╟─6ecf1438-8e25-11eb-3dce-5b49ddccc952
# ╠═170fc040-8e26-11eb-1aac-0f1318fd35c3
# ╠═ec8ce830-8e29-11eb-183d-775ac97c2a8d
# ╟─ca03cb8a-8e29-11eb-2b5f-1dd7093dba9b
# ╟─434854ac-8e2a-11eb-0ac0-6f3d970ed52f
# ╠═a2cda5ee-8e2a-11eb-296e-bf872617c5d8
# ╠═d8fd487c-8e2a-11eb-1da5-57a83d948bbf
# ╟─e1a1a22a-8e2a-11eb-152a-3b46967f4511
# ╠═f577dbc0-8e2a-11eb-2966-239e9cd074c3
# ╟─6d02b2f0-8e2b-11eb-1506-731e875d27d1
# ╠═af14e69a-8e2b-11eb-39b6-a9fb50bd20ba
