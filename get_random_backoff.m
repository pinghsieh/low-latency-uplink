function random_backoff_vec = get_random_backoff(deficit_vec, channel_prob, Rmax, N_class, CWmin)  
    Rmin = Rmax/(2^(N_class - 1));
    rate_vec = max(Rmin, exp(deficit_vec.*channel_prob));
    class_vec = max(0, ceil(log2(Rmax./rate_vec))) + 1;
    CW_vec = CWmin*(2.^(class_vec - 1));
    random_backoff_vec = floor(rand(length(deficit_vec),1).*CW_vec);
end