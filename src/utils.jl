∑(coll) = isempty(coll) ? 0. : sum(coll)

propersubsets(coll) = (S for S in subsets(coll) if 0 < length(S) < length(coll))