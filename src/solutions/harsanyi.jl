"""
Harsanyi dividends for S ⊂ N
"""
function Δₕ(G::Game, S::Players)
    G.v(S) - ∑(Δₕ(G, T) for T in propersubsets(S))
end
