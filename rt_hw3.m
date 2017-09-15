%%   Real-Time Wireless Network Simulation   
%    rt_hw3.m | A real-time wireless network of 5 clients and unreliable channels
% 
clear;
%% Part I: Initialization
% Testbench 1: Fully-symmetric system

T = 10;
N_interval = 2000;
N_client = 5;
N_run = 100;
N_policy = 3;
q_capacity = 0.877;
q_margin = 0.01;
p_n = 0.5*ones(N_client, 1);
q_n = (q_capacity - q_margin)*ones(N_client, 1);
r_n_avg = zeros(N_client, N_interval, N_policy);

%{
% Testbench 2: Asymmetric system
T = 5;
N_interval = 5000;
N_client = 3;
N_run = 20;
N_policy = 3;
p_n = [0.5; 0.5; 1];
q_n = [7/8; 7/8; 5/8];
r_n_avg = zeros(N_client, N_interval, N_policy);
%}
% Testbench 3: Asymmetric system
%{
T = 5;
N_interval = 2000;
N_client = 2;
N_run = 100;
N_policy = 3;
p_n = [0.5; 0.5];
q_n = [0.9; 0.8];
r_n_avg = zeros(N_client, N_interval, N_policy);
%}

%% Part II: Updating and scheduling
for s=1:N_policy
    u_n = zeros(N_client, 1); % number of transmissions in the interval
    for r=1:N_run
        r_n = zeros(N_client, N_interval);
        r_n_time_based = zeros(N_client, N_interval);        
        d_n = ones(N_client, N_interval); % 1 stands for that the packet still available
        for i=1:N_interval
            if i == 1
                for t=1:T 
                    schedule = rt_scheduler(s, r_n(:,i), r_n_time_based(:,i), p_n, d_n(:,i));
                    if schedule > 0
                        if unifrnd(0, 1) <= p_n(schedule)
                            d_n(schedule, i) = 0;
                        end
                        u_n(schedule) = u_n(schedule) + 1;
                    end
                end      
            else
                r_n(:,i) = subplus(r_n(:,i-1) - (d_n(:,i-1) == 0)) + q_n;
                r_n_time_based(:,i) = subplus(r_n_time_based(:,i-1) - u_n) + (q_n./p_n);
                u_n = zeros(N_client, 1);
                for t=1:T 
                    schedule = rt_scheduler(s, r_n(:,i), r_n_time_based(:,i), p_n, d_n(:,i));
                    if schedule > 0  % There is at least one available packet left
                        if unifrnd(0, 1) <= p_n(schedule)
                            d_n(schedule, i) = 0;
                        end
                        u_n(schedule) = u_n(schedule) + 1;
                    end
                end
            end
        end
        r_n_avg(:,:,s) = r_n_avg(:,:,s) + r_n;
    end
end

%% Part III: Plotting
Taxis = 1:1:N_interval;
r_n_avg = r_n_avg/N_run;
createfigure_rt(Taxis, squeeze(r_n_avg(1,:,:)));
createfigure_rt(Taxis, squeeze(r_n_avg(2,:,:)));

%% End of rt_hw3.m 