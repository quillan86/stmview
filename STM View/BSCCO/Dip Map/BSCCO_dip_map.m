function [dip_energy_map dip_val_map] = BSCCO_dip_map(data,gapmap)

[nr nc nz] = size(data.map);
energy = data.e*1000;
gap_index_map = index_val_map(gapmap,energy);
img_plot2(gap_index_map);
dip_energy_map = zeros(nr,nc);
dip_val_map = zeros(nr,nc);
for i = 1:nr
    i
    for j = 1:nc     
        j
        if gapmap(i,j) ~= 0
            pp = []; index = [];
            end_pt = gap_index_map(i,j)-1;
            y = squeeze(squeeze(data.map(i,j,1:end_pt)));            
            x = energy(1:end_pt);
            y = smooth(y,5);
            [pp index] = findpeaks(mean(y) - y);
            if ~isempty(pp)
                p = pp(end); ind = index(end);
                if (p < 0) && (size(pp,1) > 1)
                    p = pp(end-1);
                    ind = index(end-1);
                end
                dip_energy_map(i,j) = x(ind);
                dip_val_map(i,j) = p;
            end
        end
    end 
end
img_plot2(dip_energy_map);


end