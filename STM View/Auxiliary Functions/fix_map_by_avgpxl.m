function fix_map_by_avgpxl(data,error_px_val,skip_rows,skip_cols)

if isstruct(data)
    map = data.map;
else
    map = data;
end

[nr nc nz] = size(map);

[r c] = find(map == error_px_val);

for i = 1:length(r)
    if (sum(r(i) == skip_rows) == 0 ) && (sum(c(i) == skip_cols) == 0)
        [r c]
    end
end


end