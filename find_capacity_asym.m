function [I_S, g_matrix, q_capacity, q_S] = find_capacity_asym(N_client, T, p_success)
% p_success is N_client-by-1 vector
g_matrix = zeros(N_client, T);
I_S = zeros(N_client, 1);
prob_k = zeros(N_client, T);
q_S = zeros(N_client,1);

for n=1:N_client
    for j=1:T
        prob_k(n,j) = p_success(n)*((1-p_success(n))^(j-1));
    end
end

for i=1:N_client
    if i == 1
       for t=1:T
          g_matrix(i,t) = p_success(i)*((1-p_success(i))^(t-1)); 
       end
    else
       for t=i:T
          % Convolution
          g_matrix(i,t) = (fliplr(g_matrix(i-1,1:t-1)))*((prob_k(i,1:t-1))');
       end
    end
    I_S(i) = sum(g_matrix(i,1:T-1)*fliplr(1:1:T-1)');
    q_S(i) = (T - I_S(i))/sum(1./p_success(1:i));
end
q_capacity = min(q_S);
end