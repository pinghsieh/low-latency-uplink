function schedule = rand_select(d_n)
    available_set = find(d_n);
    if isempty(available_set)
       schedule = 0; 
    else
       id = randsample(length(available_set), 1);
       schedule = available_set(id);
    end
end