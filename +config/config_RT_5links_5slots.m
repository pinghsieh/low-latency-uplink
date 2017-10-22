%% Configuration File
% 5 links, deadline = 5 slots
% Time unit: millisecond
N_runs = 1;
N_frames = 10;
frame_length = 3;
T_packet = 0.;
T_backoff = 0.009;
N_links = 5;
qmax = 0.5;
rho = 0.999;
qn = 1*qmax*rho*ones(N_links,1); 
channel_prob = 0.5*ones(N_links, 1);
arrival_type = 'Bernoulli'; % One, Uniform, Bernoulli
arrival_prob = 1*ones(N_links, 1);
weight_mode = 'log';
arrival_per_frame_max = 3*ones(N_links, 1);
beta = 0;
%policy = 'LDF';
policy = 'decentralized';
gamma = 1;
N_swap = 1;
heavy_ball = 1;
