using CoordinationGames
using Test


@testset "Game" begin

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
    coalition = [1, 2, 3]
    
    @test G.v(coalition) == 4
    @test !CoordinationGames.isconvex(G)

end
