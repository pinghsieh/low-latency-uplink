function backoff_vec = get_backoff(priority_vec, swap_vec_priority, access_probability)
N_links = length(priority_vec);
backoff_vec = zeros(N_links, 1);
for i=1:N_links
    %temp = find(swap_pid >= priority_vec(i));
    %if priority_vec(i) < swap_pid
    if swap_vec_priority(priority_vec(i)) == 0
        % Not a swapping candidate
        offset = 2*(floor(nnz(swap_vec_priority(1:priority_vec(i)))/2));
        backoff_vec(i) = priority_vec(i) - 1 + offset;
    else
        % It's a swapping candidate
        offset = 2*(floor((nnz(swap_vec_priority(1:priority_vec(i)))-1)/2));
        if rand(1) < access_probability(i)
                backoff_vec(i) = priority_vec(i) - 1 + offset; 
        else
                backoff_vec(i) = priority_vec(i) + 1 + offset;
        end
    end
end 
    %[B, I] = sort(backoff_vec, 'ascend');
    %priority_vec(I) = (1:1:N_links)';
end
