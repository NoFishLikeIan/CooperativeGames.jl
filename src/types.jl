Players = Union{Vector{Int},Set{Int}}

struct SimpleGame
    N::Players
    v::Function
end

"""
A graph game extends a simple game with a list of edges,

L = [(i, j), (j, k), …]
"""
struct GraphGame
    N::Players
    v::Function
    g::SimpleGraph

    function GraphGame(
        N::Players, v::Function,
        L::Array{NTuple{2,Int}})

        n = length(N)
        g = SimpleGraph(n)

        for (i, j) in L
            add_edge!(g, i, j)
        end

        new(N, v, g)
    end
end

Game = Union{GraphGame,SimpleGame}