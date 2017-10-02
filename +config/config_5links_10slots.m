%% Configuration File
% 5 links, deadline = 10 slots
N_runs = 1;
N_frames = 10000;
N_slots_per_frame = 10;
N_links = 5;
qmax = 0.877;
rho = 0.99;
qn = qmax*rho*ones(N_links,1); 
channel_prob = 0.5*ones(N_links, 1);
arrival_type = 'One'; % One, Uniform
arrival_per_frame_max = 3*ones(N_links, 1);

