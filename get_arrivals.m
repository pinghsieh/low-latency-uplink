function arrival_vec = get_arrivals(mode, arrival_per_frame_max, arrival_prob, non_zero_prob)
% non_zero_prob: N by 1 vector

N = length(arrival_prob);
arrival_vec = zeros(N, 1);
switch mode
    case 'One'
        arrival_vec = ones(N, 1);
    case 'Uniform'
        for i=1:N
            arrival_vec(i) = randi(arrival_per_frame_max);
        end
    case 'Bernoulli'
        arrival_vec = (rand(N,1) <= arrival_prob);
    case 'Uniform-only-above-zero'
        arrival_vec = (rand(N,1) < non_zero_prob).*randi(arrival_per_frame_max, [N, 1]);

    otherwise
        for i=1:length(arrival_per_frame_max)
            arrival_vec(i) = randi(arrival_per_frame_max(i));
        end
end