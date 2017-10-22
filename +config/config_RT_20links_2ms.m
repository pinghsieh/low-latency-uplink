%% Configuration File
% 5 links, deadline = 5 slots
% Time unit: millisecond

%% System settings
%N_runs = 20;
%N_frames = 30000;
frame_length = 2; % 2ms deadline
T_packet = 0.12;
T_backoff = 0.009; % backoff = 9us
%T_backoff = 0;
T_empty = 0.06;    % empty packet = 60us
N_links = 10;
MIN_TOL = 0.001;

%% Channel Model
channel_prob = 0.7*ones(N_links, 1);
    
%% Traffic
%arrival_type = 'Uniform-only-above-zero'; % One, Uniform, Bernoulli, Uniform-only-above-zero
arrival_type = 'Bernoulli';
qmax = 0.9583;  % Suppose pn=0.7: If T=30, then qmax = 0.9710; If T=29, then qmax = 0.9583
%rho = 0.99;
%alpha_val = 0.8;
arrival_prob = alpha_val*ones(N_links, 1);
arrival_per_frame_max = 6;
lambda = 0.3;
non_zero_prob = lambda*ones(N_links,1);
switch arrival_type
    case 'One'
    qn = qmax*rho*ones(N_links,1);        
    case 'Bernoulli'
    qn = alpha_val*rho*ones(N_links,1);
    case 'Uniform-only-above-zero'
    qn = (rho*lambda*(arrival_per_frame_max + 1)/2)*ones(N_links,1);
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
