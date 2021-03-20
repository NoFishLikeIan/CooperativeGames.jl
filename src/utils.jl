function ∑(coll)
    isempty(coll) ? 0. : sum(coll)
end
function propersubsets(coll)
    (S for S in subsets(coll) if 0 < length(S) < length(coll))
end
