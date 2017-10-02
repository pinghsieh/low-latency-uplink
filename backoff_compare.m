function [id_to_priority_vec_next, output] = backoff_compare(backoff_vec, priority_to_id_vec, id_to_priority_vec, x)
output = 0;
id_to_priority_vec_next = id_to_priority_vec;

if backoff_vec(x) < backoff_vec(priority_to_id_vec(int32(id_to_priority_vec(x)-1)))
    output = 1;
    id_to_priority_vec_next(x) = id_to_priority_vec(x) - 1;
    id_to_priority_vec_next(priority_to_id_vec(id_to_priority_vec(x)-1)) = id_to_priority_vec(x); 
end

end