Players = Union{Vector{Int},Set{Int}}

struct SimpleGame
    N::Players
    v::Function
end

struct GraphGame
    N::Players
    v::Function
    L::Array{NTuple{2,Int}}
end

Game = Union{GraphGame,SimpleGame}