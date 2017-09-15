function arrival_vec = get_arrivals(mode, arrival_per_frame_max)

arrival_vec = zeros(length(arrival_per_frame_max), 1);
switch mode
    case 'One'
        arrival_vec = ones(length(arrival_per_frame_max), 1);
    case 'Uniform'
        for i=1:length(arrival_per_frame_max)
            arrival_vec(i) = randi(arrival_per_frame_max(i));
        end
    otherwise
        for i=1:length(arrival_per_frame_max)
            arrival_vec(i) = randi(arrival_per_frame_max(i));
        end
end