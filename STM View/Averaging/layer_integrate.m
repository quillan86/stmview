function new_data = layer_integrate(data,start_layer,end_layer)
if isstruct(data)
    map = data.map;
else
    map = data;
end
[nr nc nz] = size(map);
%make sure layer bounds are ordered from lowest to highest
strt_lyr = min(start_layer,end_layer);
end_lyr = max(start_layer,end_layer);
n_layers = end_lyr - strt_lyr + 1;

new_map = sum(map(:,:,strt_lyr:end_lyr),3);

if isstruct(data)
    new_data = data;
    new_data.map = new_map;
    new_data.ave = [];
    new_data.e = 1;
    new_data.var = [new_data.var '_lyr_int'];
    new_data.ops{end+1} = ['integrate layers = ' num2str(data.e(strt_lyr)) 'mV to ' num2str(data.e(end_lyr)) ' mV'];
    img_obj_viewer2(new_data);
else
    new_data = new_map;
end

    
end