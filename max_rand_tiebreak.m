function [val, out] = max_rand_tiebreak(input)
    [val, id] = max(input);
    ids = find(input == val);
    v = randperm(length(ids));
    out = ids(v(1));
end