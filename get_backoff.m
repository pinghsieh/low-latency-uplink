function backoff_vec = get_backoff(priority_vec, swap_id, access_probability)
N_links = length(priority_vec);
backoff_vec = zeros(N_links, 1);
for i=1:N_links
if priority_vec(i) < swap_id
    backoff_vec(i) = priority_vec(i) - 1;
else
    if priority_vec(i) > swap_id + 1
        backoff_vec(i) = priority_vec(i) + 1;
    else
        if rand(1) < access_probability(i)
            backoff_vec(i) = priority_vec(i) - 1; 
        else
            backoff_vec(i) = priority_vec(i) + 1;
        end
    end
end
end
    %[B, I] = sort(backoff_vec, 'ascend');
    %priority_vec(I) = (1:1:N_links)';
end
