%% Script for multi-runs
clear;
tic;
filepath = './log/RT3.log';
N_runs = 1;
N_frames = 5000;
case_id = 2;
policy = {'decentralized', 'LDF'};
%policy = {'decentralized'};
%policy = {'LDF'};
rho = 0.9;
lambda_val = [0.75, 0.74, 0.73, 0.72, 0.71, 0.7, 0.68, 0.66, 0.64];
%lambda_val = 0.4;
alpha_val = 0;
N_swap = 1;
for j=1:length(lambda_val)
    for i=1:length(policy)
        RT(filepath, N_runs, N_frames, case_id, policy{i}, alpha_val, lambda_val(j), rho, N_swap);
    end
end


toc;