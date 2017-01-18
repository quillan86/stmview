function pix_dim_dialogue(data)
[nr, nc, nz] = size(data.map);
prompt = {'New r-space Pixel Dimension','New Energy Pixel Dimension'};
dlg_title = 'Changle Map Pixel Dimensions';
num_lines = 1;
default_answer = {num2str(nr),num2str(nz)};

while 1
    answer = inputdlg(prompt,dlg_title,num_lines,default_answer);
    if isempty(answer)
        return;
    end
    if str2double(answer(1)) > 0 
        new_data = pix_dim(data,str2double(answer(1)));
            if str2double(answer(2)) > 0 
                new_data = energy_interp_map(new_data,str2double(answer(2)));
            else
                display('Enter Valid Energy Pixel Dimension > 0');    
                return;
            end
            IMG(new_data)
        return;
    else
        display('Enter Valid r-space Pixel Dimension > 0');    
    end
    
end

end