using CoordinationGames
using Test

begin # Setup
    one, two, three = [1], [2], [3]
    N = one ∪ two ∪ three


    v(S::Int) = v([S])
    function v(S::CoordinationGames.Players)
    S = sort(S)
    if S == N 4
    elseif S == one 1
        elseif S == two 2
        elseif S == three 0
        elseif S == one ∪ two 3
        elseif S == one ∪ three 3
        elseif S == two ∪ three 2
        elseif isempty(S) 0 end end

    G = CoordinationGames.Game(N, v)
end

@testset "Game" begin

    S = [1, 2, 3]
    
    @test G.v(S) == 4
    @test !CoordinationGames.isconvex(G)

end

@testset "Solutions" begin
    S = [1, 3]
    @test CoordinationGames.Δₕ(G, G.N) == -1
    @test CoordinationGames.Δₕ(G, S) == 2 

    shapley = [5 5 2]' ./ 3

    # Permutation shapley value
    @test isapprox(CoordinationGames.fₛ(G), shapley)

    # Harsanyi dividend shapley value
    HarsanyiShapley = (i -> CoordinationGames.fₛⁱ(G, i))
    @test isapprox(HarsanyiShapley.(G.N), shapley)
end
