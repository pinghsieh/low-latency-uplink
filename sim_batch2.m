%% Script for multi-runs
clear;
tic;
filepath = './log/RT2.log';
N_runs = 1;
N_frames = 50000;
case_id = 3;
%policy = {'decentralized', 'LDF'};
%policy = {'decentralized'};
policy = {'Fast-CSMA'};
%rho = 0.99;
%rho = [0.86, 0.85, 0.84, 0.82, 0.8, 0.78, 0.76, 0.74, 0.72, 0.7];
rho = [0.83 0.81];
%alpha_val = [0.05 0.1 0.15 0.2 0.25 0.3 0.35 0.4];
%alpha_val = [0.32 0.37];
alpha_val = 0.78;
lambda_val = 0;
N_swap = 1;
for k=1:length(rho)
for j=1:length(alpha_val)
    for i=1:length(policy)
        RT(filepath, N_runs, N_frames, case_id, policy{i}, alpha_val(j), lambda_val, rho(k), N_swap);
    end
end
end

toc;