using CooperativeGames
using Test

using IterTools

begin # Setup for simple graph
    one, two, three = [1], [2], [3]
    N = one ∪ two ∪ three


    v(S::Int) = v([S])
    function v(S::CooperativeGames.Players)
    S = sort(S)
    if S == N 4
    elseif S == one 1
        elseif S == two 2
        elseif S == three 0
        elseif S == one ∪ two 3
        elseif S == one ∪ three 3
        elseif S == two ∪ three 2
        elseif isempty(S) 0 end end

    G = CooperativeGames.SimpleGame(N, v)
end

@testset "SimpleGame" begin

    S = [1, 2, 3]
    
    @test G.v(S) == 4
    @test !CooperativeGames.isconvex(G)

end

@testset "Solutions" begin
    S = [1, 3]
    @test CooperativeGames.Δₕ(G, G.N) == -1
    @test CooperativeGames.Δₕ(G, S) == 2 

    shapley = [5 5 2]' ./ 3

    # Permutation shapley value
    @test isapprox(CooperativeGames.fₛ(G), shapley)

    # Harsanyi dividend shapley value
    HarsanyiShapley = (i -> CooperativeGames.fₛⁱ(G, i))
    @test isapprox(HarsanyiShapley.(G.N), shapley)

    BanhafValue = (i -> CooperativeGames.fᵦⁱ(G, i))
    banhaf = [1. 1. 0.42857]'
    @test isapprox(
        BanhafValue.(G.N), banhaf;
        atol=1e-3
    )
end

begin # Setup for undirected graph
    N = collect(1:6)
    L = [(1, 2), (1, 3), (2, 4), (3, 5), (4, 5), (5, 6)]
    v(S::CooperativeGames.Players) = (1 ∈ S && 6 ∈ S) ? 1 : 0

    G = CooperativeGames.GraphGame(N, v, L)
end

@testset "Myerson" begin
    nonzero = [
        [1,3,5,6], [1,2,3,5,6], [1,2,4,5,6],
        [1,3,4,5,6], [1,2,3,4,5,6]
    ]
    others = [s for s in subsets(G.N) if s ∉ nonzero]

    MyersonG = CooperativeGames.graphtoMyerson(G)

    @test all(map(MyersonG.v, nonzero) .== 1)
    @test all(map(MyersonG.v, others) .== 0)

    shapley = [17 / 60,  1 / 30,  1 / 12,  1 / 30,  17 / 60,  17 / 60]

    @test isapprox(CooperativeGames.fₛ(G), shapley)
    @test CooperativeGames.isfair(G, (1, 2))

end

begin # Directed graph Borm, Owen, Tijs (1992)
    vBorm(S) = [1, 2, 3] ⊆ S ? 1 : 0
    LBorm = [(1, 2), (1, 3), (1, 4), (2, 4)]

    GBorm = CooperativeGames.GraphGame(collect(1:4), vBorm, LBorm)
end

@testset "Degree Solutions" begin

    @test isapprox(CooperativeGames.fₛ(GBorm), [1 1 1 0]' ./ 3)

    @test isapprox(CooperativeGames.degreeHarsanyi(GBorm), [2 1 1 0]' ./ 4)
end