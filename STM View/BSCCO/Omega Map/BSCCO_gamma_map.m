function gamma_map = BSCCO_gamma_map(data,dip_energy_map,degree_poly,frac_peak,res)
[nr nc nz] = size(data.map);
e = data.e*1000;

if ~isfield(data,'gapmap')
    display('No Gap Map exists in current data structure');
    return;
else
    gap_map = data.gapmap;
end

% find index in energy vector whose values closest to gap value
gap_index_map = index_val_map(gap_map,e);
dip_index_map = index_val_map(dip_energy_map,e);
%load_color
%img_plot2(gap_index,Cmap.Defect1,'Gap Index');

gamma_map = zeros(nr,nc);
map = data.map;
for i = 1:nr    
    for j = 1:nc
        i
        j
        y = squeeze(squeeze(map(i,j,:)));
        if gap_map(i,j)*dip_energy_map(i,j) ~=0          
            gamma_map(i,j) = BSCCO_gamma_pt_v2(y,e,dip_index_map(i,j),gap_index_map(i,j),degree_poly,frac_peak,res);
        end
    end
end

end