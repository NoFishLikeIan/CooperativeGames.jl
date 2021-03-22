using Pkg

currentpath = splitpath(pwd())
moduledir = joinpath(currentpath[1:end - 1]...)

Pkg.develop(PackageSpec(path=moduledir))

using Documenter


makedocs(sitename="CooperativeGames.jl")
