function fix_pixel_auto(data,n_std)
[nr,nc,nz] = size(data.map);
new_data = data;
for k = 1:nz
    map_lyr = squeeze(data.map(:,:,k));
    std_map = std(reshape(map_lyr,nr*nc,1));
    mean_map = mean(mean(map_lyr));
    A = abs(map_lyr - mean_map) > n_std*std_map;
    map_lyr(A) = mean_map;
    new_data.map(:,:,k) = map_lyr;
end
IMG(new_data);
end