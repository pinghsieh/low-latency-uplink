function [swap_vec_id, swap_vec_priority, swap_pid] = get_swap_vec(N_links, N_swap, priority_to_id_vec, SWAP_LEAD, SWAP_TRAIL)
if N_swap > floor((N_links-1)/2)
     N_swap = floor((N_links-1)/2);
end
swap_vec_id = zeros(N_links, 1);
swap_vec_priority = zeros(N_links, 1);
% Determine odd groups or even groups
if rand(1) < 0.5
    % odd
    temp(randperm(length(1:2:N_links-1))) = (1:2:N_links-1)';
    swap_pid = temp(1:N_swap);
else
    % even
    temp(randperm(length(2:2:N_links-1))) = (2:2:N_links-1)';
    swap_pid = temp(1:N_swap);
end
swap_pid = sort(swap_pid);
swap_vec_id(priority_to_id_vec(swap_pid)) = SWAP_LEAD;
swap_vec_id(priority_to_id_vec(swap_pid+1)) = SWAP_TRAIL;
swap_vec_priority(swap_pid) = SWAP_LEAD;
swap_vec_priority(swap_pid+1) = SWAP_TRAIL;
end