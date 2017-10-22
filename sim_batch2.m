%% Script for multi-runs
clear;
tic;
filepath = './log/RT2.log';
N_runs = 20;
N_frames = 50000;
case_id = 3;
%policy = {'decentralized', 'LDF'};
%policy = {'decentralized'};
policy = {'Fast-CSMA'};
rho = 0.99;
alpha_val = [0.05 0.1 0.15 0.2 0.25 0.3 0.35];
%alpha_val = 0.77;
lambda_val = 0;
N_swap = 1;
for j=1:length(alpha_val)
    for i=1:length(policy)
        RT(filepath, N_runs, N_frames, case_id, policy{i}, alpha_val(j), lambda_val, rho, N_swap);
    end
end

toc;