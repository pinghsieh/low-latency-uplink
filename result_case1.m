%% Results for case id = 1
% 20 links, deadline = 20ms
N_links = 20;
%% Part 1: delivery ratio = 0.9
lambda_LDF = [0.6, 0.59, 0.58, 0.57, 0.56];
N_runs = length(lambda_LDF);
time_average_deficit_LDF = zeros(N_runs, N_links);
time_average_deficit_LDF(1,:) = [3.4 4.9 3.8 3.6 3.6 4.0 4.2 3.9 4.2 3.6 4.3 4.2 4.2 4.1 3.3 4.0 4.5 4.2 3.7 3.8];
time_average_deficit_LDF(2,:) =
time_average_deficit_LDF(3,:) = [0.0 0.0 0.0 0.0 0.0 0.1 0.0 0.1 0.0 0.1 0.0 0.5 0.3 0.0 0.0 0.0 0.0 0.0 0.0 0.0];
time_average_deficit_LDF(4,:) =
time_average_deficit_LDF(5,:) = [0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.1];

lambda_decentralized = [0.6, 0.58, 0.56, 0.54, 0.5];
N_runs = length(lambda_decentralized);
time_average_deficit_dec = zeros(N_runs, N_links);
time_average_deficit_dec(1,:) = [128.4 124.5 74.5 80.5 125.8 81.0 107.6 108.1 110.7 136.7 96.6 84.7 97.4 102.6 130.8 72.7 99.0 124.2 124.3 97.3];
time_average_deficit_dec(2,:) = [4.4 9.7 2.4 3.2 13.0 5.3 1.7 3.7 7.0 3.5 2.8 4.3 3.7 6.3 2.5 1.4 4.7 2.6 4.2 6.7];
time_average_deficit_dec(3,:) = [1.4 0.6 0.9 0.2 2.2 1.4 1.0 0.6 1.4 2.6 2.5 2.6 2.8 1.1 2.2 0.8 2.5 2.9 3.3 1.1];
time_average_deficit_dec(4,:) = [0.6 0.9 0.3 0.4 0.7 1.4 0.3 1.4 0.9 0.3 1.8 0.8 0.5 2.6 0.8 1.1 1.2 1.4 0.8 0.7]; 
time_average_deficit_dec(5,:) = [0.0 0.2 0.8 0.1 0.7 0.5 0.1 0.1 0.1 0.0 0.2 0.3 0.5 0.3 0.1 0.4 0.2 0.5 0.2 0.2];

%% Part 2: alpha = 0.6