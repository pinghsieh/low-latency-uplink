%% Configuration File
% 5 links, deadline = 5 slots
% Time unit: millisecond

% System settings
N_runs = 1;
N_frames = 10000;
frame_length = 3; % 3ms deadline
T_packet = 0.1;
T_backoff = 0.009; % backoff = 9us
T_empty = 0.05;    % empty packet = 30us
N_links = 9;

% Traffic
qmax = 0.998;  % Suppose pn=0.5: If T=30, then qmax = 0.9987; If T=29, then qmax = 0.9980
rho = 0.999;
qn = 1*qmax*rho*ones(N_links,1); 
channel_prob = 0.5*ones(N_links, 1);
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
