"""
Check if a solution x is in the core of G. Namely,

    - ∑ x < v(N)
    - ∑ₛ x < v(S) ∀ S

"""
function isincore(x::Vector{Float64}, G::Game)
    if sum(x) != G.v(G.N) return false end

    for S in subsets(G.N)
        if sum(x[S]) < G.v(S) return false end
    end

    return true

end