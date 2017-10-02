%% Configuration File
% 10 links, deadline = 15 slots
N_runs = 30;
N_frames = 6000;
N_slots_per_frame = 15;
N_links = 10;
qmax = 0.6814;
rho = 0.999;
qn = 1*qmax*rho*ones(N_links,1); 
channel_prob = [0.3; 0.3; 0.4; 0.4; 0.5; 0.5; 0.6; 0.6; 0.7; 0.7];
arrival_type = 'Bernoulli'; % One, Uniform, Bernoulli
arrival_prob = 1*ones(N_links, 1);
weight_mode = 'log';
arrival_per_frame_max = 3*ones(N_links, 1);
beta = 0;
%policy = 'LDF';
policy = 'decentralized';
gamma = 1;
N_swap = 2;
heavy_ball = 1;

