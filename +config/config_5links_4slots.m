%% Configuration File
% 5 links, deadline = 4 slots
N_runs = 1;
N_frames = 10000;
N_slots_per_frame = 4;
N_links = 5;
qmax = 0.4;
rho = 0.99;
qn = 1*qmax*rho*ones(N_links,1); 
channel_prob = 0.5*ones(N_links, 1);
arrival_type = 'Bernoulli'; % One, Uniform, Bernoulli
arrival_prob = 1*ones(N_links, 1);
weight_mode = 'log';
arrival_per_frame_max = 3*ones(N_links, 1);

