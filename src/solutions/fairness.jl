function isfair(G::GraphGame, L::NTuple{2,Int})
    isfair(G, Edge(L))
end
function isfair(G::GraphGame, L::Edge)

    g′ = copy(G.g)
    rem_edge!(g′, L)

    G′ = GraphGame(G.N, G.v, g′)

    i, j = L.src, L.dst

    f′ = fₛ(G′)
    f = fₛ(G)

    return f[i] - f′[i] ≈ f[j] - f′[j]

end

