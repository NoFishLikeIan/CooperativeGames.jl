"""
Banzhaf (1965) value
"""
function fᵦⁱ(G::Game, i::Int)
    N = length(G.N)
    
    banzhaf = ∑(
        G.v(S) - G.v(setdiff(S, i))
        for S in subsets(G.N)
            if i ∈ S
    )

    return banzhaf ./ (2^N - 1)
end
