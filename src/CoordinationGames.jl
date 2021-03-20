module CoordinationGames

# Write your package code here.

using IterTools
using Base.Iterators
using Combinatorics

include("utils.jl")
include("games.jl")
include("solutions/harsanyi.jl")
include("solutions/shapley.jl")
include("solutions/core.jl")

end
