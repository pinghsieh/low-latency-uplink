%% Distributed Algorithm For Ultra-low latency wireless
clear;
tic;

%% Some Constants
SWAP_LEAD = 1;
SWAP_TRAIL = 2;

%% Part 1: Configuration
%config.config_3links_4slots;
config.config_5links_5slots_asym;
%config.config_10links_15slots_asym;
%config.config_21links_40slots;
deficit_history_avg = zeros(N_links, N_frames);
heavy_deficit_history_avg = zeros(N_links, N_frames);
throughput_history_avg = zeros(N_links, N_frames);

%% Part 2: Distributed Algorithm
for m=1:N_runs
id_to_priority_vec = randperm(N_links)';
backoff_vec = zeros(N_links, 1);
packets_vec = zeros(N_links, 1);
deficit_vec = zeros(N_links, 1); % use delivery debt
heavy_deficit_vec = zeros(N_links, 1); % for heavy ball
access_prob = zeros(N_links, 1);
priority_to_id_vec = zeros(N_links, 1);
deficit_history = zeros(N_links, N_frames);  
heavy_deficit_history = zeros(N_links, N_frames); 
throughput_history = zeros(N_links, N_frames);
avg_deficit_history = zeros(N_links, N_frames);
avg_heavy_deficit_history = zeros(N_links, N_frames);

% Use a temp vector to store the changes in priority vector
id_to_priority_vec_next = id_to_priority_vec;

for t=1:N_frames
% Update state variables at the beginning of each frame
u = 0;    
rn = get_weight(heavy_deficit_vec, weight_mode);
%access_prob = exp(max(0,rn).*channel_prob)./(exp(max(0,rn).*channel_prob) + gamma);
%access_prob = exp(max(0,rn))./(exp(max(0,rn)) + gamma); % pn information is not needed
access_prob = exp(rn)./(exp(rn) + gamma);
id_to_priority_vec = id_to_priority_vec_next;
priority_to_id_vec(id_to_priority_vec) = (1:N_links)';
%swap_vec(priority_to_id_vec([swap_pid swap_pid + 1]), 1) = [1; 2];

% a boolean vector to indicate whether a node is to be swapped
[swap_vec_id, swap_vec_priority, swap_pid] = get_swap_vec(N_links, N_swap, priority_to_id_vec, SWAP_LEAD, SWAP_TRAIL);
backoff_vec = get_backoff(id_to_priority_vec, swap_vec_priority, access_prob);
packets_vec = double(get_arrivals(arrival_type, arrival_per_frame_max, arrival_prob));
deficit_vec = deficit_vec + qn;
heavy_deficit_vec = heavy_deficit_vec + qn;

% Heavy-Ball
if t > 2
    if heavy_ball == 1
        heavy_deficit_vec = heavy_deficit_vec + beta*(heavy_deficit_history(:,t-1) - heavy_deficit_history(:,t-2));
    end
end

% Update history
if t > 1
        throughput_history(:,t) = throughput_history(:,t-1)*(t-1); 
        avg_deficit_history(:,t) = avg_deficit_history(:,t-1)*(t-1) + deficit_vec; 
        avg_heavy_deficit_history(:,t) = avg_heavy_deficit_history(:,t-1)*(t-1) + heavy_deficit_vec;         
end

while u < N_slots_per_frame
    
    %% 1. Priority-Based Deecentralized Approach
    % A node is available if backoff time is >=0 and (with a packet OR is in to-be-swapped pair)
    switch policy
        case 'decentralized'
        available_nodes = find((backoff_vec >= 0).*(packets_vec > 0 | swap_vec_id > 0));
        node_count = N_links - length(available_nodes) + 1;
        if isempty(available_nodes)
            break
        else
            [val, nid] = min(backoff_vec(available_nodes)); 
            backoff_vec = backoff_vec - val;
            %if id_to_priority_vec(available_nodes(nid)) ~= node_count
            %    x = find(id_to_priority_vec == node_count);
            %    id_to_priority_vec(available_nodes(nid)) = node_count;
            %    id_to_priority_vec(x) = node_count + 1;
            %end
        
            % Check if swapping is needed
            if (swap_vec_id(available_nodes(nid)) == SWAP_TRAIL) 
                id_to_priority_vec_next = backoff_compare(backoff_vec, priority_to_id_vec, id_to_priority_vec, available_nodes(nid));
            end
        
            % Avoid infinite loop due to empty packet
            swap_vec_id(available_nodes(nid)) = 0;
        
            n_tx = min(packets_vec(available_nodes(nid)), N_slots_per_frame - u);
            n_delivered = get_delivered_packets(n_tx, channel_prob(available_nodes(nid)));
            throughput_history(available_nodes(nid),t) = throughput_history(available_nodes(nid),t) + n_delivered;
            deficit_vec(available_nodes(nid)) = deficit_vec(available_nodes(nid)) - n_delivered; 
            heavy_deficit_vec(available_nodes(nid)) = heavy_deficit_vec(available_nodes(nid)) - n_delivered;
            avg_deficit_history(available_nodes(nid),t) = avg_deficit_history(available_nodes(nid),t) - n_delivered;
            avg_heavy_deficit_history(available_nodes(nid),t) = avg_heavy_deficit_history(available_nodes(nid),t) - n_delivered;
            packets_vec(available_nodes(nid)) = packets_vec(available_nodes(nid)) - n_delivered;
            u = u + n_tx;
        end
    
        %% 2. Largest-Debt First Policy
        case 'LDF'
            available_nodes = find(packets_vec > 0);
            if isempty(available_nodes)
                break
            else
                %[val, nid] = max_rand_tiebreak((max(0, deficit_vec(available_nodes))).*channel_prob(available_nodes));% Random Tie Breaking
                [val, nid] = max_rand_tiebreak(deficit_vec(available_nodes));% Random Tie Breaking

                n_tx = min(packets_vec(available_nodes(nid)), N_slots_per_frame - u);
                n_delivered = get_delivered_packets(n_tx, channel_prob(available_nodes(nid)));
                throughput_history(available_nodes(nid),t) = throughput_history(available_nodes(nid),t) + n_delivered;
                deficit_vec(available_nodes(nid)) = deficit_vec(available_nodes(nid)) - n_delivered; 
                heavy_deficit_vec(available_nodes(nid)) = heavy_deficit_vec(available_nodes(nid)) - n_delivered;
                avg_deficit_history(available_nodes(nid),t) = avg_deficit_history(available_nodes(nid),t) - n_delivered;
                avg_heavy_deficit_history(available_nodes(nid),t) = avg_heavy_deficit_history(available_nodes(nid),t) - n_delivered;
                packets_vec(available_nodes(nid)) = packets_vec(available_nodes(nid)) - n_delivered;
                u = u + n_tx;   
            end
    end
end
throughput_history(:,t) = throughput_history(:,t)/t;
avg_deficit_history(:,t) = avg_deficit_history(:,t)/t;
deficit_history(:,t) = deficit_vec;
avg_heavy_deficit_history(:,t) = avg_heavy_deficit_history(:,t)/t;
heavy_deficit_history(:,t) = heavy_deficit_vec;
end
deficit_history_avg =  deficit_history_avg + deficit_history;
heavy_deficit_history_avg =  heavy_deficit_history_avg + heavy_deficit_history;
throughput_history_avg = throughput_history_avg + throughput_history;
fprintf('Run: %d\n', m);
toc;
end

deficit_history_avg = deficit_history_avg./N_runs;
heavy_deficit_history_avg =  heavy_deficit_history_avg./N_runs;
throughput_history_avg = throughput_history_avg./N_runs;

%% Part 3: Plotting
%plot(1:1:N_frames, deficit_history);
Step_size = 1;
createfigure(1:Step_size:N_frames, deficit_history_avg(:,1:Step_size:N_frames), 'deficit', N_links);
hold off;
createfigure(1:Step_size:N_frames, throughput_history_avg(:,1:Step_size:N_frames), 'throughput', N_links);
hold off;
%createfigure(1:1:N_frames, avg_deficit_history, 'deficit', N_links);
toc;