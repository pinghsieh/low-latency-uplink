%% Distributed Algorithm For Ultra-low latency wireless
clear;
tic;
%% Part 1: Configuration
config.config_5links_10slots;
deficit_history_avg = zeros(N_links, N_frames);

%% Part 2: Distributed Algorithm
for m=1:N_runs
priority_vec = randperm(N_links)';
backoff_vec = zeros(N_links, 1);
packets_vec = zeros(N_links, 1);
deficit_vec = zeros(N_links, 1); % use delivery debt
access_prob = zeros(N_links, 1);
arrival_per_frame_max = 3*ones(N_links, 1);

gamma = 1;
deficit_history = zeros(N_links, N_frames);  

for t=1:N_frames
u = 0;    
swap_id = get_swapid(N_links); 
rn = get_weight(deficit_vec);
access_prob = exp(max(0,rn).*channel_prob)./(exp(max(0,rn).*channel_prob) + gamma);
backoff_vec = get_backoff(priority_vec, swap_id, access_prob);
packets_vec = get_arrivals(arrival_type, arrival_per_frame_max);
deficit_vec = deficit_vec + packets_vec.*(qn);


while u < N_slots_per_frame
    available_nodes = find((backoff_vec >= 0).*(packets_vec > 0));
    node_count = N_links - length(available_nodes) + 1;
    if isempty(available_nodes)
        break
    else
        [val, nid] = min(backoff_vec(available_nodes)); 
        backoff_vec = backoff_vec - val;
        if priority_vec(available_nodes(nid)) ~= node_count
             x = find(priority_vec == node_count);
             priority_vec(available_nodes(nid)) = node_count;
             priority_vec(x) = node_count + 1;
        end
        n_tx = min(packets_vec(available_nodes(nid)), N_slots_per_frame - u);
        n_delivered = get_delivered_packets(n_tx, channel_prob(available_nodes(nid)));
        deficit_vec(available_nodes(nid)) = deficit_vec(available_nodes(nid)) - n_delivered; 
        packets_vec(available_nodes(nid)) = packets_vec(available_nodes(nid)) - n_delivered;
        u = u + n_tx;
    end
end

deficit_history(:,t) = deficit_vec;
end
deficit_history_avg =  deficit_history_avg + deficit_history;
fprintf('Run: %d\n', m);
toc;
end

deficit_history_avg = deficit_history_avg./N_runs;

%% Part 3: Plotting
%plot(1:1:N_frames, deficit_history);
plot(1:1:N_frames, deficit_history_avg);
toc;