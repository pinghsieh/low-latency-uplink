%% Configuration File
% 20 links, deadline = 20ms
% Time unit: millisecond

%% System settings
%N_runs = 1;
%N_frames = 5000;
frame_length = 20; % 10ms deadline
T_packet = 0.33;
T_backoff = 0.009; % backoff = 9us
T_empty = 0.06;    % empty packet = 60us
N_group1 = 10;
N_group2 = 10;
N_links = N_group1 + N_group2;
MIN_TOL = 0.001;

%% Channel Model
channel_prob = zeros(N_links, 1);
channel_prob(1:N_group1, 1) = 0.8*ones(N_group1, 1);
channel_prob(N_group1+1:N_links, 1) = 0.5*ones(N_group2, 1);

%% Traffic
arrival_type = 'Uniform-only-above-zero'; % One, Uniform, Bernoulli, Uniform-only-above-zero
%arrival_type = 'Bernoulli';
qmax = 0.9583;  % Suppose pn=0.7: If T=30, then qmax = 0.9710; If T=29, then qmax = 0.9583
%rho = 0.99;
%alpha_val = 0.8;
arrival_prob = 1*ones(N_links, 1);
arrival_per_frame_max = 6;
%lambda = 0.5;
%delivery_ratio = 0.9;
lambda_val1= 1;
lambda_val2= 0.5;
non_zero_prob = zeros(N_links, 1);
non_zero_prob(1:N_group1, 1) = lambda_val*lambda_val1*ones(N_group1, 1);
non_zero_prob(N_group1+1:N_links, 1) = lambda_val*lambda_val2*ones(N_group2, 1);

switch arrival_type
    case 'One'
    qn = qmax*rho*ones(N_links,1); 
    case 'Bernoulli'
    qn = alpha_val*rho*ones(N_links,1);
    case 'Uniform-only-above-zero'
    %qn = (rho*lambda_val*(arrival_per_frame_max + 1)/2)*ones(N_links,1);
    qn = (rho*(arrival_per_frame_max + 1)/2)*non_zero_prob;
end
%% Policy
weight_mode = 'log';
beta_val = 0;
%policy = 'LDF';
%policy = 'decentralized';
%policy = 'Fast-CSMA';
gamma_val = 10;
%N_swap = 1;
heavy_ball = 1;
% Fast CSMA
Rmax = exp(5);
N_class = 6;
CWmin = 32;
