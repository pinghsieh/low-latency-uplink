function rn = get_weight(deficit_vec)

%rn = log(max(1, log(max(1, deficit_vec))));
rn = log(max(1, 100*deficit_vec));
%rn = 0.01*deficit_vec;

end