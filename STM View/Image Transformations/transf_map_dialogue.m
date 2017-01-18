function transf_map_dialogue(data)
fh=figure('Name', 'Select Transform Matrix',...
        'units','normalized', ...
        'Position',[0.3,0.2,0.16,0.1],...
        'Color',[0.6 0.6 0.6],...
        'MenuBar', 'none',...
        'NumberTitle', 'off',...
        'Resize','off');


data_names = fieldnames(data);
str = [data_names{1} '|'];
for i = 2:length(data_names)-1
    str = [str data_names{i} '|'];
end
str = [str data_names{end}];

name_pop = uicontrol(fh,'Style', 'popup',... 
       'units','normalized',...
       'Value',1,...
       'String', str,...
       'Position', [0.05 0.35 0.5 0.5]);
   
OK_but = uicontrol(fh,'Style','pushbutton',...
                          'String','OK',...
                          'units','normalized',...
                          'Position',[0.6 0.65 0.2 0.2],...
                          'Callback',(@OK_Callback));
cancel_but = uicontrol(fh,'Style','pushbutton',...
                          'String','Cancel',...
                          'units','normalized',...
                          'Position',[0.6 0.35 0.2 0.2],...
                          'Callback',(@cancel_Callback));

%%%%%%%%%%%%%%%%%%%%%%%%%%CALLBACK FUNCTIONS%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
uiwait(gcf); 
%halt execution of STM_View until this function returns a file to open

function OK_Callback(hObject,eventdata)
   val = get(name_pop,'Value');
   name = data_names{val};
   if isempty(name)
       display('Empty Field');
       return;
   end
   t_matrix = eval(['data.' name]);
   new_data = transf_img(data,t_matrix);
   new_data.ops{end+1} = ['affine tranformation w/ ' name];
   IMG(new_data);
    
   close(fh);
end
    function cancel_Callback(hObject,eventdata)      
        close(fh);
    end
end