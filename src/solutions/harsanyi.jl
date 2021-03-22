"""
Harsanyi dividends for S ⊂ N
"""
function Δₕ(G::Game, S::Players)
    G.v(S) - ∑(Δₕ(G, T) for T in propersubsets(S))
end

function degreeHarsanyi(G::GraphGame)
    game = graphtoMyerson(G)
    ϕ = zeros(length(G.N))

    for S in subsets(G.N)
        sg, vmap = induced_subgraph(G.g, S)
                
        Δ = Δₕ(game, S)
        ds = degree(sg)
        dsum = sum(ds)

        if dsum == 0 continue end

        for (i, d) in enumerate(ds)
            ϕ[vmap[i]] += (Δ * d) / dsum
        end
    end

    return ϕ
end
    