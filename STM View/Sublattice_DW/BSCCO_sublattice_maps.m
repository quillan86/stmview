function [Ox_map, Oy_map, Cu_map] = BSCCO_sublattice_maps(data)

[nr nc nz] = size(data.map);
Ox_pos = data.Ox;
Oy_pos = data.Oy;
Cu_pos = data.Cu;


Ox_pos2 = zeros(nr,nc);
Oy_pos2 = zeros(nr,nc);
Cu_pos2 = zeros(nr,nc);
width = 0;
for i = 2:nr-1
    for j = 2:nc-1
        if Ox_pos(i,j) ==1
            min_i = max(i-width,1);
            max_i = min(i+width,nr);
            min_j = max(j-width,1);
            max_j = min(j+width,nc);
            Ox_pos2(min_i:max_i,min_j:max_j) = 1;
        end
        if Oy_pos(i,j) ==1
            min_i = max(i-width,1);
            max_i = min(i+width,nr);
            min_j = max(j-width,1);
            max_j = min(j+width,nc);
            Oy_pos2(min_i:max_i,min_j:max_j) = 1;
        end
        if Cu_pos(i,j) ==1
            min_i = max(i-width,1);
            max_i = min(i+width,nr);
            min_j = max(j-width,1);
            max_j = min(j+width,nc);
            Cu_pos2(min_i:max_i,min_j:max_j) = 1;
        end
    end
end
%img_plot2(Ox_pos2);
%img_plot2(Oy_pos2);
Ox_map = data;
Oy_map = data;
Cu_map = data;
for k = 1:nz    
    Ox_map.map(:,:,k) = data.map(:,:,k).*Ox_pos2;        
    Oy_map.map(:,:,k) = data.map(:,:,k).*Oy_pos2;
    Cu_map.map(:,:,k) = data.map(:,:,k).*Cu_pos2;
end
Ox_map.var = 'Ox_map';
Ox_map.ops = {};
Oy_map.var = 'Oy_map';
Oy_map.ops = {};
Cu_map.var = 'Cu_map';
Cu_map.ops = {};

% img_obj_viewer2(Ox_map); 
% img_obj_viewer2(Oy_map); 
% img_obj_viewer2(Cu_map);


end