%% Script for multi-runs
clear;
tic;
filepath = './log/RT.log';
N_runs = 20;
N_frames = 50000;
case_id = 3;
policy = {'decentralized', 'LDF'};
%policy = {'decentralized'};
%policy = {'LDF'};
rho = 0.99;
alpha_val = [0.8, 0.76, 0.74, 0.72, 0.7, 0.68, 0.66, 0.6];
%alpha_val = 0.77;
lambda_val = 0;
N_swap = 1;
for j=1:length(alpha_val)
    for i=1:length(policy)
        RT(filepath, N_runs, N_frames, case_id, policy{i}, alpha_val(j), lambda_val, rho, N_swap);
    end
end


toc;