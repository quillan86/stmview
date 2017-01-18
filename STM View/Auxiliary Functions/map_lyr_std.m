function lyr_std = map_lyr_std(data)
if isstruct(data)
    map = data.map;
else
    map = data;
end
[nr nc nz] = size(data.map);
lin_dim = nc*nr;
lyr_std = zeros(1,nz);
for i = 1:nz
    lin_map = reshape(data.map(:,:,i),1,lin_dim);
    lyr_std(i) = std(lin_map);
end

end