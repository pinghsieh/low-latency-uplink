function schedule = largest_debt_first(r_n_time_based, d_n)
    available_set = find(d_n);
    if isempty(available_set)
        schedule = 0;
    else
        weight = r_n_time_based(available_set);
        [value, id] = max(weight);
        schedule = available_set(id); 
    end
end