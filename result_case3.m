%% Results for case id = 3
% 10 links, deadline = 2ms
clear;
N_links = 10;
%% Part 1: delivery ratio = 0.99
lambda_LDF = [0.84, 0.82, 0.81, 0.8, 0.78, 0.76, 0.74, 0.72, 0.7, 0.6, 0.4];
N_runs_LDF = length(lambda_LDF);
time_average_deficit_LDF = zeros(N_runs_LDF, N_links);
time_average_deficit_LDF(1,:) = [47.0 43.3 44.0 42.9 44.3 44.8 44.1 46.8 43.6 43.9];
time_average_deficit_LDF(2,:) = [26.7 24.0 22.8 27.8 31.0 24.3 24.1 31.1 27.5 25.9];
time_average_deficit_LDF(3,:) = [3.5 3.8 14.5 6.6 3.6 1.9 4.3 5.9 8.8 6.2];
time_average_deficit_LDF(4,:) = [0.6 3.7 0.1 0.4 0.2 0.6 0.4 0.0 0.5 0.5];
time_average_deficit_LDF(5,:) = [0.7 0.4 0.2 0.3 0.3 0.2 0.0 0.4 0.3 0.2];
time_average_deficit_LDF(6,:) = [0.8 0.6 1.3 0.0 0.3 1.6 0.2 0.0 0.1 0.1]; 
time_average_deficit_LDF(7,:) = [1.8 0.0 1.7 1.1 0.1 0.1 0.1 0.1 0.6 0.6];
time_average_deficit_LDF(8,:) = [0.6 0.0 0.0 1.3 0.1 0.0 0.5 0.2 0.0 2.1]; 
time_average_deficit_LDF(9,:) = [1.8 0.2 0.2 0.4 0.2 1.3 0.0 2.0 0.0 0.2];
time_average_deficit_LDF(10,:) = [0.0 0.0 0.8 0.0 3.4 0.8 1.3 0.0 0.8 0.1]; 
time_average_deficit_LDF(11,:) = [11.4 0.4 2.0 0.2 5.4 0.0 0.0 0.1 1.5 0.0 ];
%plot(lambda_LDF, mean(time_average_deficit_LDF, 2));
%hold on;
%plot(lambda_LDF, max(time_average_deficit_LDF, [], 2));

lambda_decentralized = [0.78, 0.76, 0.74, 0.72, 0.7, 0.68, 0.66, 0.64, 0.6, 0.4];
N_runs_dec = length(lambda_decentralized);
time_average_deficit_dec = zeros(N_runs_dec, N_links);
time_average_deficit_dec(1,:) = [87.9 99.9 52.5 72.4 75.1 51.0 38.5 184.4 77.2 57.3]; 
time_average_deficit_dec(2,:) = [28.4 21.3 40.2 60.6 29.7 32.9 32.2 42.3 33.6 58.2];
time_average_deficit_dec(3,:) = [12.2 9.8 8.5 7.9 7.1 9.2 7.8 4.1 7.6 10.6];
time_average_deficit_dec(4,:) = [4.8 5.1 4.3 8.4 2.8 6.9 6.8 7.2 10.0 5.6];
time_average_deficit_dec(5,:) = [1.2 1.9 1.2 1.8 2.1 3.2 4.2 0.1 7.0 0.5];
time_average_deficit_dec(6,:) = [2.1 0.2 3.6 13.8 0.1 0.2 0.2 4.1 0.6 0.3];
time_average_deficit_dec(7,:) = [0.5 0.1 10.0 1.2 2.3 2.7 3.5 3.2 0.1 3.8];
time_average_deficit_dec(8,:) = [0.4 0.2 8.4 0.7 2.8 0.8 5.2 0.3 0.6 0.0];
time_average_deficit_dec(9,:) = [0.0 0.0 1.1 0.1 0.0 0.3 0.3 1.4 11.0 0.0]; 
time_average_deficit_dec(10,:) = [9.6 1.1 2.3 0.4 6.1 0.0 0.3 0.0 0.9 0.0]; 
%plot(lambda_decentralized, mean(time_average_deficit_dec, 2));
%hold on;
%plot(lambda_decentralized, max(time_average_deficit_dec, [], 2));

lambda_fastCSMA = [0.05, 0.1, 0.15, 0.2, 0.25, 0.3, 0.32 0.35];
N_runs_fCSMA = length(lambda_fastCSMA);
time_average_deficit_fCSMA = zeros(N_runs_fCSMA, N_links);
time_average_deficit_fCSMA(1,:) = [64.7 19.5 52.1 16.1 34.9 15.9 48.8 15.6 17.9 19.8];
time_average_deficit_fCSMA(2,:) = [36.1 26.0 23.3 22.1 38.5 43.7 29.7 22.9 36.4 23.2];
time_average_deficit_fCSMA(3,:) = [26.5 38.2 15.5 47.0 29.5 40.0 31.4 25.0 31.7 46.6];
time_average_deficit_fCSMA(4,:) = [35.4 28.0 24.4 77.0 76.0 38.3 34.2 64.7 17.0 30.8];
time_average_deficit_fCSMA(5,:) = [24.0 98.3 35.5 56.8 101.2 34.3 39.0 59.9 77.2 44.5]; 
time_average_deficit_fCSMA(6,:) = [150.8 61.4 47.4 63.0 113.4 38.5 107.4 60.2 121.0 30.4];
time_average_deficit_fCSMA(7,:) = [73.4 36.4 187.9 97.6 153.4 106.3 119.8 52.9 73.6 27.3]; 
time_average_deficit_fCSMA(8,:) = [198.7 46.4 64.2 126.5 159.7 157.6 126.9 76.8 146.6 83.8]; 
%plot(lambda_fastCSMA, mean(time_average_deficit_fCSMA, 2));
%hold on;
%plot(lambda_fastCSMA, max(time_average_deficit_fCSMA, [], 2));

createfigure_3lines(lambda_LDF, mean(time_average_deficit_LDF,2), lambda_decentralized, mean(time_average_deficit_dec,2), lambda_fastCSMA, mean(time_average_deficit_fCSMA,2));
%% Part 2: alpha = 0.78
clear;
N_links = 10;

rho_LDF = [0.995, 0.992, 0.99, 0.985, 0.98, 0.97, 0.95, 0.9];
N_runs_LDF = length(rho_LDF);
time_average_deficit_LDF = zeros(N_runs_LDF, N_links);
time_average_deficit_LDF(1,:) = [64.8 73.1 70.1 66.1 65.3 66.0 65.9 70.7 72.8 73.3];
time_average_deficit_LDF(2,:) = [9.4 5.9 13.1 16.5 9.2 13.2 6.2 6.9 7.2 8.0]; 
time_average_deficit_LDF(3,:) = [2.8 2.4 0.9 2.7 3.2 1.9 3.4 0.7 1.2 0.2]; 
time_average_deficit_LDF(4,:) = [0.1 0.0 0.0 0.0 0.0 0.2 0.0 0.0 0.0 0.0]; 
time_average_deficit_LDF(5,:) = [0.0 0.0 0.0 0.0 0.0 0.0 0.1 0.0 0.0 0.0];
time_average_deficit_LDF(6,:) = [0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0]; 
time_average_deficit_LDF(7,:) = [0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0];
time_average_deficit_LDF(8,:) = [0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0];

rho_dec = [0.992, 0.99, 0.985, 0.98, 0.97, 0.95, 0.9];
N_runs_dec = length(rho_dec);
time_average_deficit_dec = zeros(N_runs_dec, N_links);
time_average_deficit_dec(1,:) = [48.8 71.0 101.9 58.2 82.6 95.0 39.5 83.4 58.5 198.2]; 
time_average_deficit_dec(2,:) = [53.5 73.3 34.9 131.8 63.8 75.6 44.5 37.5 42.2 66.4];
time_average_deficit_dec(3,:) = [3.4 3.3 4.0 3.9 6.3 4.1 2.2 5.2 2.9 5.6]; 
time_average_deficit_dec(4,:) = [0.3 0.6 0.1 0.5 0.5 0.2 1.1 0.2 0.2 0.7]; 
time_average_deficit_dec(5,:) = [0.1 0.1 0.0 0.1 0.0 0.0 0.0 0.1 0.0 0.0];
time_average_deficit_dec(6,:) = [0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0]; 
time_average_deficit_dec(7,:) = [0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0];

rho_fCSMA = [0.865, 0.86, 0.85, 0.84, 0.83, 0.82, 0.81, 0.8, 0.78, 0.76];
N_runs_fCSMA = length(rho_fCSMA);
time_average_deficit_fCSMA = zeros(N_runs_fCSMA, N_links);
time_average_deficit_fCSMA(1,:) = [110.3 162.2 244.1 130.4 170.5 214.3 185.7 181.4 184.8 254.9]; 
time_average_deficit_fCSMA(2,:) = [81.6 108.9 64.9 186.3 122.9 155.5 89.4 66.1 61.8 48.8];
time_average_deficit_fCSMA(3,:) = [19.2 14.3 16.4 13.9 14.3 20.8 18.1 17.8 15.1 16.2];
time_average_deficit_fCSMA(4,:) = [11.2 11.6 11.8 10.9 11.6 10.2 11.5 10.9 11.1 10.4];
time_average_deficit_fCSMA(5,:) = [8.9 8.5 8.5 8.5 8.6 9.2 9.2 8.8 9.5 8.8]; 
time_average_deficit_fCSMA(6,:) = [8.3 8.1 8.1 8.0 7.8 8.2 8.2 8.2 8.1 8.0];
time_average_deficit_fCSMA(7,:) = [7.6 7.6 7.6 7.6 7.6 7.7 7.7 7.5 7.5 7.6]; 
time_average_deficit_fCSMA(8,:) = [7.2 7.2 7.2 7.2 7.2 7.3 7.2 7.2 7.2 7.2];
time_average_deficit_fCSMA(9,:) = [6.8 6.8 6.8 6.9 6.9 6.8 6.8 6.9 6.8 6.9]; 
time_average_deficit_fCSMA(10,:) = [6.6 6.5 6.6 6.6 6.6 6.6 6.6 6.5 6.5 6.5]; 

createfigure_3lines_case3(rho_LDF, mean(time_average_deficit_LDF,2), rho_dec, mean(time_average_deficit_dec,2),rho_fCSMA, mean(time_average_deficit_fCSMA,2));
%createfigure_6lines_case3(rho_LDF, mean(time_average_deficit_LDF,2), rho_LDF, max(time_average_deficit_LDF,[],2),...
                        %rho_dec, mean(time_average_deficit_dec,2), rho_dec, max(time_average_deficit_dec,[], 2),...
                        %rho_fCSMA, mean(time_average_deficit_fCSMA,2), rho_fCSMA, max(time_average_deficit_fCSMA,[], 2));


