function crop_map_in_energy_dialogue(data)

e1 = data.e(1);
e2 = data.e(end);

prompt={'Start Point', 'End Point'};
name='Crop in z-direction end points';

numlines=1;         
defaultanswer={num2str(e1),num2str(e2)};
answer = inputdlg(prompt,name,numlines,defaultanswer);

st_ind = find_nearest_index(data.e,str2double(answer{1}))
end_ind = find_nearest_index(data.e,str2double(answer{2}))

new_data = crop_map_in_energy(data,st_ind,end_ind);
IMG(new_data);

end