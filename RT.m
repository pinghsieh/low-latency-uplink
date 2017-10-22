function RT(filepath, N_runs, N_frames, case_id, policy, alpha_val, lambda_val, rho, N_swap)
%% Distributed Algorithm For Ultra-low latency wireless

%% Some Constants
SWAP_LEAD = 1;
SWAP_TRAIL = 2;

%% Part 1: Configuration
%config.config_RT_3links_1ms;
%config.config_RT_3links_1ms_asymmetric;
%config.config_RT_20links_10ms;
switch case_id
    case 1
        config.config_RT_20links_20ms;
    case 2
        config.config_RT_20links_20ms_asymmetric;    
    case 3
        config.config_RT_20links_2ms;
    otherwise
        config.config_RT_20links_2ms;       
end

% Log file
fileID = fopen(filepath, 'a');
fprintf(fileID, '\n************************************************************\n');
fprintf(fileID, '*** Date Time: %s\n', datetime('now'));
fprintf(fileID,'*** Case ID: %d\n*** N links = %d, deadline = %d ms, N runs = %d, N frames = %d\n', case_id, N_links, frame_length, N_runs, N_frames);
fprintf(fileID, '*** Policy = %s, N_swap = %d \n', policy, N_swap);
formatSpec = '%.3f ';
fprintf(fileID, '*** qn = ');
fprintf(fileID, formatSpec, qn);
fprintf(fileID, '\n');
fprintf(fileID, '*** channel = ');
fprintf(fileID, formatSpec, channel_prob);
fprintf(fileID, '\n');
switch arrival_type
    case 'Bernoulli'
        fprintf(fileID, '*** Arrival type = %s, alpha = %.3f, rho = %.3f \n', arrival_type, alpha_val, rho);
    case 'Uniform-only-above-zero'
        fprintf(fileID, '*** Arrival type = %s, delivery ratio = %.3f, lambda = %.3f, max arrival = %d\n', arrival_type, rho, lambda_val, arrival_per_frame_max); 
end
deficit_history_avg = zeros(N_links, N_frames);
heavy_deficit_history_avg = zeros(N_links, N_frames);
throughput_history_avg = zeros(N_links, N_frames);
max_deficit_history = zeros(N_links, N_runs);

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
    
% For debug
if rem(t,5000) == 0
    fprintf('t = %d\n', t);
end
% Update state variables at the beginning of each frame
t_now = 0;
rn = get_weight(heavy_deficit_vec, weight_mode);
%access_prob = exp(max(0,rn).*channel_prob)./(exp(max(0,rn).*channel_prob) + gamma);
%access_prob = exp(max(0,rn))./(exp(max(0,rn)) + gamma); % pn information is not needed
access_prob = exp(rn)./(exp(rn) + gamma_val);
id_to_priority_vec = id_to_priority_vec_next;
priority_to_id_vec(id_to_priority_vec) = (1:N_links)';
%swap_vec(priority_to_id_vec([swap_pid swap_pid + 1]), 1) = [1; 2];

% Use a boolean vector to indicate whether a node is to be swapped
[swap_vec_id, swap_vec_priority, swap_pid] = get_swap_vec(N_links, N_swap, priority_to_id_vec, SWAP_LEAD, SWAP_TRAIL);
backoff_vec = get_backoff(id_to_priority_vec, swap_vec_priority, access_prob);
packets_vec = double(get_arrivals(arrival_type, arrival_per_frame_max, arrival_prob, non_zero_prob));
deficit_vec = deficit_vec + qn;
heavy_deficit_vec = heavy_deficit_vec + qn;

% Empty packet for claiming priority
% If a link is chosen as candidate but has no packet, 
% then create an empty packet whose value is 0.5 (just for recognition)
if strcmp(policy, 'decentralized')
    packets_vec = packets_vec + 0.5*((packets_vec == 0).*(swap_vec_id > 0));
end

% Heavy-Ball
if t > 2
    if heavy_ball == 1
        heavy_deficit_vec = heavy_deficit_vec + beta_val*(heavy_deficit_history(:,t-1) - heavy_deficit_history(:,t-2));
    end
end

% Update history
if t > 1
        throughput_history(:,t) = throughput_history(:,t-1)*(t-1); 
        avg_deficit_history(:,t) = avg_deficit_history(:,t-1)*(t-1) + deficit_vec; 
        avg_heavy_deficit_history(:,t) = avg_heavy_deficit_history(:,t-1)*(t-1) + heavy_deficit_vec;         
end

%while u < N_slots_per_frame
while t_now < frame_length 
    t_tx = 0; % measure the transmission time used in the current loop
    t_remain = frame_length - t_now;
    n_delivered = 0;
    %% 1. Priority-Based Deecentralized Approach
    % A node is available if backoff time is >=0 and (with a packet OR is in to-be-swapped pair)
    switch policy
        case 'decentralized'
            available_nodes = find((backoff_vec >= 0).*(packets_vec > MIN_TOL | swap_vec_id > 0));
            time_for_hoq_packet = get_time_for_hoq_packet(packets_vec, T_packet, T_empty, frame_length, MIN_TOL);
            min_time_for_next_packet = min(time_for_hoq_packet); 
            % Break while loop if no packets remaining or the remaining time
            % not enough for a packet
            %if min_time_for_next_packet > t_remain
            %break
            %else
            [backoff_val, nid] = min(backoff_vec(available_nodes)); 
            if backoff_val > 0
                t_now = t_now + backoff_val*T_backoff;
                backoff_vec = backoff_vec - backoff_val;
                continue
            end
            time_for_next_packet = time_for_hoq_packet(available_nodes(nid));
            if isempty(available_nodes) || (time_for_next_packet > t_remain)
                break
            end
            % Check if swapping is needed
            if (swap_vec_id(available_nodes(nid)) == SWAP_TRAIL) 
                id_to_priority_vec_next = backoff_compare(backoff_vec, priority_to_id_vec, id_to_priority_vec, available_nodes(nid));
            end
        
            % Avoid infinite loop due to empty packet
            swap_vec_id(available_nodes(nid)) = 0;
        
            % TODO: Handle packet transmissions and time evolution
            if packets_vec(available_nodes(nid)) >= 1            
                % Normal DATA packets
                n_tx_needed_for_one_transmission = get_number_transmissions(channel_prob(available_nodes(nid)));
                n_tx_available = floor(t_remain/T_packet);
                %n_tx = min(packets_vec(available_nodes(nid)), floor((frame_length - t_now)/T_packet));
                if n_tx_needed_for_one_transmission <= n_tx_available          
                    n_delivered = 1;
                    n_packet_decrease = 1;
                else
                    n_delivered = 0;
                    n_packet_decrease = 0;
                end
                n_tx = min(n_tx_needed_for_one_transmission, n_tx_available);
                t_tx = n_tx*T_packet;
            else  
                % Empty packet has value n_packet_decrease = 0.5
                n_tx = 0;
                t_tx = T_empty; 
                n_delivered = 0;
                n_packet_decrease = 0.5;
            end
            throughput_history(available_nodes(nid),t) = throughput_history(available_nodes(nid),t) + n_delivered;
            deficit_vec(available_nodes(nid)) = deficit_vec(available_nodes(nid)) - n_delivered; 
            heavy_deficit_vec(available_nodes(nid)) = heavy_deficit_vec(available_nodes(nid)) - n_delivered;
            avg_deficit_history(available_nodes(nid),t) = avg_deficit_history(available_nodes(nid),t) - n_delivered;
            avg_heavy_deficit_history(available_nodes(nid),t) = avg_heavy_deficit_history(available_nodes(nid),t) - n_delivered;
            packets_vec(available_nodes(nid)) = packets_vec(available_nodes(nid)) - n_packet_decrease;
            t_now = t_now + t_tx;
        %end
    
        %% 2. Largest-Debt First Policy
        case 'LDF'
            available_nodes = find(packets_vec > 0);
            min_time_for_next_packet = min(get_time_for_hoq_packet(packets_vec, T_packet, T_empty, frame_length, MIN_TOL)); 
            if min_time_for_next_packet > t_remain
                break
            else
                %[val, nid] = max_rand_tiebreak((max(0, deficit_vec(available_nodes))).*channel_prob(available_nodes));% Random Tie Breaking
                [val, nid] = max_rand_tiebreak(deficit_vec(available_nodes));% Random Tie Breaking

                % TODO: Handle packet transmissions and time evolution
                if packets_vec(available_nodes(nid)) >= 1            
                    % Normal DATA packets
                    n_tx_needed_for_one_transmission = get_number_transmissions(channel_prob(available_nodes(nid)));
                    n_tx_available = floor(t_remain/T_packet);
                    if n_tx_needed_for_one_transmission <= n_tx_available          
                        n_delivered = 1;
                    else
                        n_delivered = 0;
                    end
                    n_tx = min(n_tx_needed_for_one_transmission, n_tx_available);
                    t_tx = n_tx*T_packet;
                end
                throughput_history(available_nodes(nid),t) = throughput_history(available_nodes(nid),t) + n_delivered;
                deficit_vec(available_nodes(nid)) = deficit_vec(available_nodes(nid)) - n_delivered; 
                heavy_deficit_vec(available_nodes(nid)) = heavy_deficit_vec(available_nodes(nid)) - n_delivered;
                avg_deficit_history(available_nodes(nid),t) = avg_deficit_history(available_nodes(nid),t) - n_delivered;
                avg_heavy_deficit_history(available_nodes(nid),t) = avg_heavy_deficit_history(available_nodes(nid),t) - n_delivered;
                packets_vec(available_nodes(nid)) = packets_vec(available_nodes(nid)) - n_delivered;
                t_now = t_now + t_tx;  
            end
        %% 3. Fast-CSMA Policy
        case 'Fast-CSMA'
            available_nodes = find(packets_vec > 0);
            min_time_for_next_packet = min(get_time_for_hoq_packet(packets_vec, T_packet, T_empty, frame_length, MIN_TOL));
            if min_time_for_next_packet > t_remain
                break
            else
                % Generate backoff numbers for those having packets
                random_backoff_vec = get_random_backoff(heavy_deficit_vec, channel_prob, Rmax, N_class, CWmin);
                min_backoff = min(random_backoff_vec(available_nodes));
                t_min_backoff = min_backoff*T_backoff;
                nid = find(random_backoff_vec(available_nodes) == min_backoff);
                % Update t_now after backoff
                t_now = t_now + t_min_backoff;
                t_remain = frame_length - t_now;
                if T_packet < t_remain
                    if length(nid) == 1
                        % No collision
                        % TODO: Handle packet transmissions and time evolution
                        if packets_vec(available_nodes(nid)) >= 1            
                            if rand(1) < channel_prob(available_nodes(nid))        
                                n_delivered = 1;
                            else
                                n_delivered = 0;
                            end
                            t_tx = 1*T_packet;
                        end
                    else
                        % collision
                        t_tx = 1*T_packet;
                        n_delivered = 0;
                    end
                    t_now = t_now + t_tx;
                else
                    break
                end
                throughput_history(available_nodes(nid),t) = throughput_history(available_nodes(nid),t) + n_delivered;
                deficit_vec(available_nodes(nid)) = deficit_vec(available_nodes(nid)) - n_delivered; 
                heavy_deficit_vec(available_nodes(nid)) = heavy_deficit_vec(available_nodes(nid)) - n_delivered;
                avg_deficit_history(available_nodes(nid),t) = avg_deficit_history(available_nodes(nid),t) - n_delivered;
                avg_heavy_deficit_history(available_nodes(nid),t) = avg_heavy_deficit_history(available_nodes(nid),t) - n_delivered;
                packets_vec(available_nodes(nid)) = packets_vec(available_nodes(nid)) - n_delivered;
            end
    end
end
throughput_history(:,t) = throughput_history(:,t)/t;
avg_deficit_history(:,t) = avg_deficit_history(:,t)/t;
deficit_history(:,t) = deficit_vec;
avg_heavy_deficit_history(:,t) = avg_heavy_deficit_history(:,t)/t;
heavy_deficit_history(:,t) = heavy_deficit_vec;
end
deficit_history_avg =  deficit_history_avg + max(deficit_history,0);
heavy_deficit_history_avg =  heavy_deficit_history_avg + heavy_deficit_history;
throughput_history_avg = throughput_history_avg + throughput_history;
max_deficit_history(:, m) = max(0, max(deficit_history, [], 2));
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
time_average_deficit = mean(deficit_history_avg, 2);
mean_max_deficit = mean(max_deficit_history, 2);
formatSpec = '%.1f ';
fprintf(fileID, '*** Time average deficit:\n');
fprintf(fileID, formatSpec, time_average_deficit);
fprintf(fileID, '\n');
fprintf(fileID, '*** Mean max deficit:\n');
fprintf(fileID, formatSpec, mean_max_deficit);
%createfigure(1:1:N_frames, avg_deficit_history, 'deficit', N_links);
fclose(fileID);