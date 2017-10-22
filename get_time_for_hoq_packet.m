function  output = get_time_for_hoq_packet(packets_vec, T_packet, T_empty, frame_length, MIN_TOL)
% If no packet, then assign NaN
% If at least 1 data packet, assign T_packet
% If one empty packet, assign T_empty
    T_null = frame_length + 1;
    output = T_packet*(packets_vec >= 1) + T_empty*((packets_vec < 1) & (packets_vec > 0)) + T_null*(packets_vec <= MIN_TOL);
end