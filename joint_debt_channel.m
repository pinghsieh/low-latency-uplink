function schedule = joint_debt_channel(r_n, p_n, d_n)
    available_set = find(d_n);
    if isempty(available_set)
        schedule = 0;
    else
        weight = r_n(available_set).*p_n(available_set);
        [value, id] = max(weight);
        schedule = available_set(id);       
    end
end