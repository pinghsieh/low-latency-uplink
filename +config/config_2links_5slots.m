%% Configuration File
% 2 links, deadline = 5
N_runs = 10;
N_frames = 2000;
N_slots_per_frame = 5;
N_links = 2;
qn = [0.97; 0.82]; 
channel_prob = 0.5*ones(N_links, 1);
arrival_type = 'Bernoulli'; % One, Uniform, Bernoulli
arrival_prob = 1*ones(N_links, 1);
weight_mode = 'log';
arrival_per_frame_max = 3*ones(N_links, 1);
beta = 0;
policy = 'LDF';
%policy = 'decentralized';
gamma = 1;