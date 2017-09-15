function backoff_vec = get_backoff(priority_vec, swap_id, access_probability)

backoff_vec = zeros(length(priority_vec), 1);
for i=1:length(priority_vec)
if priority_vec(i) < swap_id
    backoff_vec(i) = priority_vec(i) - 1;
else
    if priority_vec(i) > swap_id + 1
        backoff_vec(i) = priority_vec(i) + 1;
    else
        if rand(1) > access_probability(i)
            backoff_vec(i) = priority_vec(i) - 1; 
        else
            backoff_vec(i) = priority_vec(i) + 1;
        end
    end
end
end