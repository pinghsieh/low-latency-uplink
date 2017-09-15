%% Distributed Algorithm For Ultra-low latency wireless
clear;
%% Part 1: Configuration
config.config_5links_10slots;

%% Part 2: Distributed Algorithm

priority_vec = randperm(N_links)';
backoff_vec = zeros(N_links, 1);
packets_vec = zeros(N_links, 1);
deficit_vec = zeros(N_links, 1); % use delivery debt
access_prob = zeros(N_links, 1);
arrival_per_frame_max = 3*ones(N_links, 1);
deficit_history = zeros(N_links, N_frames);

for t=1:N_frames
u = 0;    
swap_id = randi(N_links - 1);    
access_prob = exp(max(0,deficit_vec).*channel_prob)./(exp(max(0,deficit_vec).*channel_prob) + 1);
backoff_vec = get_backoff(priority_vec, swap_id, access_prob);
packets_vec = get_arrivals(arrival_type, arrival_per_frame_max);
deficit_vec = deficit_vec + packets_vec.*qn;

while u < N_slots_per_frame
    available_nodes = find((backoff_vec >= 0).*(packets_vec > 0));
    if isempty(available_nodes)
        break
    else
        [val, nid] = min(backoff_vec(available_nodes)); 
        backoff_vec = backoff_vec - val;
        n_tx = min(packets_vec(available_nodes(nid)), N_slots_per_frame - u);
        n_delivered = get_delivered_packets(n_tx, channel_prob(available_nodes(nid)));
        deficit_vec(available_nodes(nid)) = deficit_vec(available_nodes(nid)) - n_delivered; 
        packets_vec(available_nodes(nid)) = packets_vec(available_nodes(nid)) - n_delivered;
        u = u + n_tx;
    end
end
deficit_history(:,t) = deficit_vec;

end

%% Part 3: Plotting
plot(1:1:N_frames, deficit_history);
