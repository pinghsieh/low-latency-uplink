function [I_S, g_matrix, q_capacity, q_S] = find_capacity(N_client, T, p_success)
g_matrix = zeros(N_client, T);
I_S = zeros(N_client, 1);
prob_k = zeros(T, 1);
q_S = zeros(N_client,1);

for j=1:T
    prob_k(j) = p_success*((1-p_success)^(j-1));
end
for i=1:N_client
    if i == 1
       for t=1:T
          g_matrix(i,t) = 1 - (1-p_success)^t; 
       end
    else
       for t=i:T
          g_matrix(i,t) = (fliplr(g_matrix(i-1,1:t-1)))*((prob_k(1:t-1,1)));
       end
    end
    I_S(i) = sum(g_matrix(i,i:T-1));
    q_S(i) = (T - I_S(i))*p_success/N_client;
end
q_capacity = max(q_S);
end