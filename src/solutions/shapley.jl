"""
Shapey value using Harsanyi dividends
"""
function fₛⁱ(G::Game, i::Int)
    ∑(Δₕ(G, T) / length(T) for T in subsets(G.N) if i ∈ T)
end

"""
Shapey value using permutations
"""
function fₛ(G::Game)
    N = length(G.N)
    Nσ = factorial(N)

    shapley = zeros(N)

    for n in 1:Nσ
        σ = nthperm(G.N, n)
        
        for (i, s) in enumerate(σ)
            shapley[s] += G.v(σ[1:i]) - G.v(σ[1:i - 1])
        end
        
    end

    return shapley ./ Nσ
end