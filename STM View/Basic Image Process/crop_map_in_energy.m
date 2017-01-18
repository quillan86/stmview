function new_data = crop_map_in_energy(data,st_pt,end_pt)

if st_pt > end_pt
    spc = -1;
else
    spc = 1;
end

if isstruct(data)
    map = data.map;
    new_data = data;
    new_data.map = map(:,:,st_pt:spc:end_pt);
    new_data.e = data.e(st_pt:spc:end_pt);
    new_data.ave = squeeze(squeeze(mean(mean(new_data.map))));
    new_data.ops{end+1} = ['Crop in z-dir: index ' num2str(st_pt) ' - ' num2str(end_pt)];
    new_data.var = [new_data.var '_cropE'];
else
    map = data;
    new_data = map(:,:,st_pt:spc:end_pt);
end

end