%% Results for case id = 3
% 10 links, deadline = 2ms
N_links = 10;
%% Part 1: delivery ratio = 0.99
lambda_LDF = [0.82, 0.81, 0.8, 0.78, 0.76, 0.74, 0.72, 0.7];
N_runs = length(lambda_LDF);
time_average_deficit_LDF = zeros(N_runs, N_links);
time_average_deficit_LDF(1,:) = [26.7 24.0 22.8 27.8 31.0 24.3 24.1 31.1 27.5 25.9];
time_average_deficit_LDF(2,:) = [3.5 3.8 14.5 6.6 3.6 1.9 4.3 5.9 8.8 6.2];
time_average_deficit_LDF(3,:) = [0.6 3.7 0.1 0.4 0.2 0.6 0.4 0.0 0.5 0.5];
time_average_deficit_LDF(4,:) = [16.3 1.5 1.0 2.3 1.6 0.8 0.2 0.1 0.1 1.5];
time_average_deficit_LDF(5,:) = [0.8 0.6 1.3 0.0 0.3 1.6 0.2 0.0 0.1 0.1]; 
time_average_deficit_LDF(6,:) = [1.8 0.0 1.7 1.1 0.1 0.1 0.1 0.1 0.6 0.6];
time_average_deficit_LDF(7,:) = [0.6 0.0 0.0 1.3 0.1 0.0 0.5 0.2 0.0 2.1]; 
time_average_deficit_LDF(8,:) = [1.8 0.2 0.2 0.4 0.2 1.3 0.0 2.0 0.0 0.2]; 

lambda_decentralized = [0.8, 0.76, 0.74, 0.72, 0.7, 0.68, 0.66, 0.64];
N_runs = length(lambda_decentralized);
time_average_deficit_dec = zeros(N_runs, N_links);
time_average_deficit_dec(1,:) = [93.1 50.8 210.9 78.7 133.0 46.6 77.5 65.7 38.3 84.2];
time_average_deficit_dec(2,:) = [28.4 21.3 40.2 60.6 29.7 32.9 32.2 42.3 33.6 58.2];
time_average_deficit_dec(3,:) = [12.2 9.8 8.5 7.9 7.1 9.2 7.8 4.1 7.6 10.6];
time_average_deficit_dec(4,:) = [4.8 5.1 4.3 8.4 2.8 6.9 6.8 7.2 10.0 5.6];
time_average_deficit_dec(5,:) = [1.2 1.9 1.2 1.8 2.1 3.2 4.2 0.1 7.0 0.5];
time_average_deficit_dec(6,:) = [2.1 0.2 3.6 13.8 0.1 0.2 0.2 4.1 0.6 0.3];
time_average_deficit_dec(7,:) = [1.3 0.0 0.4 1.1 0.4 1.7 0.3 4.0 1.3 28.0];
time_average_deficit_dec(8,:) = [0.4 0.2 8.4 0.7 2.8 0.8 5.2 0.3 0.6 0.0];

lambda_fastCSMA = [0.05, 0.1, 0.15, 0.2, 0.25, 0.3, 0.35];

%% Part 2: lambda = 0.8
