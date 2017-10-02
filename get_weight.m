function rn = get_weight(deficit_vec, mode)

switch mode
    case 'loglog'
        rn = log(max(1, log(max(1, deficit_vec))));
    case 'log'
        rn = log(max(1, 100*(deficit_vec+10)));
    case 'linear'
        rn = 1*deficit_vec;
    otherwise
        rn = log(max(1, 100*deficit_vec));

end