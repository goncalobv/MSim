function val = responsetime (time_vector, data_vector, tolerance)
    start = find(data_vector == max(data_vector), 1, 'first');
    for x=start:size(data_vector,2)
        if(data_vector(x) <= tolerance)
            val=[x time_vector(x) data_vector(x)];
            return
        end
    end
    val = [-1 0 0];
end