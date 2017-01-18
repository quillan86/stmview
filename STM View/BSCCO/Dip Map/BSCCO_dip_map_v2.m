function [dip_val_map dip_energy_map] = BSCCO_dip_map_v2(data,gapmap)

[nr nc nz] = size(data.map);
energy = data.e*1000;
gap_index_map = index_val_map(gapmap,energy);
img_plot2(gap_index_map);
dip_energy_map = zeros(nr,nc);
dip_val_map = zeros(nr,nc);
for i = 1:nr
    i
    for j = 1:nc 
        
        if gapmap(i,j) ~= 0
            spectrum = squeeze(squeeze(data.map(i,j,:)));
           [dip_val_map(i,j) dip_energy_map(i,j)] = BSCCO_dip_pt(spectrum,energy,gap_index_map(i,j),6);
        end
    end 
end
img_plot2(dip_energy_map);
img_plot2(dip_val_map);

end