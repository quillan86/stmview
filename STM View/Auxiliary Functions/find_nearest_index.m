% given a vector x, find the index i, for this x(i) is closest to val
% there may be several such solution for which val_index is an array
function val_index = find_nearest_index(x,val)
    val_index = find_zero_crossing(x-val);
    if isempty(val_index)
        val_index = 0;
    end
end