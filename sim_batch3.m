%% Script for multi-runs
clear;
tic;
filepath = './log/RT3.log';
N_runs = 20;
N_frames = 50000;
case_id = 1;
policy = {'decentralized', 'LDF'};
%policy = {'decentralized'};
%policy = {'LDF'};
rho = 0.9;
lambda_val = [0.6, 0.58, 0.56, 0.54, 0.52, 0.5, 0.45, 0.4];
%lambda_val = 0.4;
alpha_val = 0;
N_swap = 1;
for j=1:length(lambda_val)
    for i=1:length(policy)
        RT(filepath, N_runs, N_frames, case_id, policy{i}, alpha_val, lambda_val(j), rho, N_swap);
    end
end


toc;