function BSCCO_dip_map_dialogue(data,obj_handle)

if ~isfield(data,'gapmap')
    display('Data Object needs gap map data to proceed');
    return;
end

[dip_energy_map dip_val_map] = BSCCO_dip_map(data,data.gapmap);
new_data = data;
new_data.dip_energy_map = dip_energy_map;
new_data.dip_val_map = dip_val_map;
guidata(obj_handle,new_data);
img_plot2(dip_energy_map,'Dip Energy Map');
img_plot2(dip_val_map,'Dip Value Map');

end