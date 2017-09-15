function schedule = rt_scheduler(pid, r_n, r_n_time_based, p_n, d_n)
    switch pid
        case 1
            schedule = rand_select(d_n);
        case 2
            schedule = joint_debt_channel(r_n, p_n, d_n);
        case 3
            schedule = largest_debt_first(r_n_time_based, d_n);
        otherwise
            schedule = rand_select(d_n);
    end
end