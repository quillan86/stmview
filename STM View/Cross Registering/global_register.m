function global_register(data)


if ~isfield(data,'t_form')
    display('No t_form field');
    return;
end
new_data=data;
new_data.map = [];
for i=1:size(data.map,3)
    new_data.map(:,:,i)=imwarp(squeeze(data.map(:,:,i)), data.t_form.T, 'OutputView', imref2d(data.t_form.size));
end
new_data.r = data.t_form.r;
new_data.var = [data.var '_registered'];
new_data.ops{end+1} = 'Registration';
IMG(new_data);

end