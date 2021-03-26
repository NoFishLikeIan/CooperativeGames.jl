module CooperativeGames

    using IterTools
    using Base.Iterators
    using Combinatorics
    using LightGraphs

    include("types.jl")
    include("utils.jl")
    include("games.jl")
    include("graphs.jl")
    include("solutions/harsanyi.jl")
    include("solutions/shapley.jl")
    include("solutions/banzhaf.jl")
    include("solutions/core.jl")
    include("solutions/fairness.jl")

    export Players, SimpleGame, GraphGame,

        # Methods
        isconvex, isfair, graphtoMyerson,

        # Solutions
        Δₕ, fₛ, fₛⁱ, fᵦⁱ, degreeHarsanyi
        

end
