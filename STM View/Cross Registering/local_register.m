function local_register(data)

if ~isfield(data,'t_form_local')
    display('No t_form field');
    return;
end
new_data=data;

for i=1:size(new_data.map,3)
    new_data.map(:,:,i)=imwarp(squeeze(new_data.map(:,:,i)), new_data.t_form_local, 'OutputView', imref2d(size( squeeze(new_data.map(:,:,i)))));
    
end

new_data.var = [new_data.var '_registered'];
new_data.ops{end+1} = 'Registration';

IMG(new_data);
end