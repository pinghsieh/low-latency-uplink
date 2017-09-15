%% Configuration File
% 5 links, deadline = 10 slots
N_runs = 10;
N_frames = 10000;
N_slots_per_frame = 10;
N_links = 5;
qmax = 0.877;
qn = 0.877*ones(N_links,1); 
channel_prob = 0.5*ones(N_links, 1);
arrival_type = 'One'; % One, Uniform


