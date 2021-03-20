Players = Union{Vector{Int},Set{Int}}

struct Game
    N::Players
    v::Function
end

"""
Maps v to every possible coalition P(G)
"""
function valuemapping(G::Game)
    ((S, G.v(S)) for S in subsets(G.N))
end

"""
Breadth first test of convexity of a game,

For all S, T ∈ P(G):
v(S ∪ T) + v(S ∩ T) < v(S) + v(T)
"""
function isconvex(G::Game)
    v = G.v
    coalitions = subsets(G.N)

    for (i, T) in enumerate(coalitions)
        for S in drop(coalitions, i)
            if v(S ∪ T) + v(S ∩ T) < v(S) + v(T)
                return false
            end
        end
    end

    return true
end
