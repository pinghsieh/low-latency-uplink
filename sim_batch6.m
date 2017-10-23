%% Script for multi-runs
clear;
tic;
filepath = './log/RT4.log';
N_runs = 1;
N_frames = 50000;
case_id = 2;
%policy = {'decentralized', 'LDF'};
%policy = {'decentralized'};
%policy = {'LDF'};
policy = {'Fast-CSMA'};
rho = 0.9;
%rho = [0.82, 0.81, 0.8, 0.79, 0.77, 0.75];
%lambda_val = [0.6, 0.58, 0.56, 0.54, 0.52, 0.5, 0.45, 0.4];
%lambda_val = [0.45 0.42 0.39 0.36 0.33 0.3 0.27];
lambda_val = 0.55;
alpha_val = 0;
N_swap = 1;
for k=1:length(rho)
for j=1:length(lambda_val)
    for i=1:length(policy)
        RT(filepath, N_runs, N_frames, case_id, policy{i}, alpha_val, lambda_val(j), rho(k), N_swap);
    end
end
end


toc;