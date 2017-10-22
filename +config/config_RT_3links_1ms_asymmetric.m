%% Configuration File
% 5 links, deadline = 5 slots
% Time unit: millisecond

% System settings
N_runs = 1;
N_frames = 2000;
frame_length = 1; % 1ms deadline
T_packet = 0.15;
T_backoff = 0.009; % backoff = 9us
T_empty = 0.05;    % empty packet = 30us
N_links = 3;

% Traffic
qmax = 0.7807;  % Suppose pn=0.5: If T=6, then qmax = 0.8438;
rho = 0.999;
qn = 1*qmax*rho*ones(N_links,1); 
channel_prob = [0.3; 0.5; 0.8];
arrival_type = 'Bernoulli'; % One, Uniform, Bernoulli
arrival_prob = 1*ones(N_links, 1);

% Policy
weight_mode = 'log';
arrival_per_frame_max = 3*ones(N_links, 1);
beta = 0;
%policy = 'LDF';
policy = 'decentralized';
gamma = 1;
N_swap = 1;
heavy_ball = 1;
