function output = get_number_transmissions(channel_prob)
    % The support of 'geornd' is {0,1,2,...} 
    output = geornd(channel_prob) + 1;
end  