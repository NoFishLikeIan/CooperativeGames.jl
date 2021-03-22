"""
Convert a graph game to a simple game based on Myerson (1977). Namely, assume v(S) > 0 iff S is connected subgraph.
"""
function graphtoMyerson(G::GraphGame)::SimpleGame
    function vᴸ(S::Players)
        subgraph, vmap = induced_subgraph(G.g, S)
        comps = [
            [vmap[i] for i in comp] 
            for comp in connected_components(subgraph)]

        return ∑(G.v(T) for T in comps)
    end
    
    return SimpleGame(G.N, vᴸ)
end
