%% Configuration File
% 5 links, deadline = 5 slots
% Time unit: millisecond

%% System settings
N_runs = 1;
N_frames = 5000;
frame_length = 10; % 10ms deadline
T_packet = 0.33;
T_backoff = 0.009; % backoff = 9us
T_empty = 0.05;    % empty packet = 30us
N_links = 20;
MIN_TOL = 0.001;

%% Channel Model
channel_prob = 0.7*ones(N_links, 1);
    
%% Traffic
arrival_type = 'Uniform-only-above-zero'; % One, Uniform, Bernoulli, Uniform-only-above-zero
%arrival_type = 'Bernoulli';
qmax = 0.9583;  % Suppose pn=0.7: If T=30, then qmax = 0.9710; If T=29, then qmax = 0.9583
rho = 0.99;
arrival_prob = 1*ones(N_links, 1);
arrival_per_frame_max = 5;
lambda = 0.3;
delivery_ratio = 0.9;
non_zero_prob = lambda*ones(N_links,1);
switch arrival_type
    case 'Bernoulli'
    qn = qmax*rho*ones(N_links,1);
    case 'Uniform-only-above-zero'
    qn = (delivery_ratio*lambda*(arrival_per_frame_max + 1)/2)*ones(N_links,1);
end
%% Policy
weight_mode = 'log';
beta = 0;
%policy = 'LDF';
policy = 'decentralized';
%policy = 'Fast-CSMA';
gamma = 10;
N_swap = 1;
heavy_ball = 1;
% Fast CSMA
Rmax = exp(5);
N_class = 6;
CWmin = 32;
