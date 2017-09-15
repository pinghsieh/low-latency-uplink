function output = get_delivered_packets(n_tx, channel_prob)
    output = binornd(n_tx, channel_prob);

end