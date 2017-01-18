function auto_fix_pixel_dialogue(data)

prompt = {'Enter N: Pixel value std error to fix'};
        dlg_title = 'Angular Average in Polar Polar';
        num_lines = 1;
        default_answer = {'1'};
        answer = inputdlg(prompt,dlg_title,num_lines,default_answer);    
        fix_pixel_auto(data,str2double(answer));
end