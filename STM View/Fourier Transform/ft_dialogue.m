function new_data = ft_dialogue(data)
fh=figure('Name', 'Fourier Transform Options',...
        'units','normalized', ...
        'Position',[0.3,0.3,0.18,0.1],...
        'Color',[0.6 0.6 0.6],...
        'MenuBar', 'none',...
        'NumberTitle', 'off',...
        'Resize','off');

    
    str1 = 'complex|real|imaginary|ampltude|phase';

ft_type_pop = uicontrol(fh,'Style', 'popup',... 
       'units','normalized',...
       'Value',1,...
       'String', str1,...
       'Position', [0.01 0.35 0.4 0.6]);

   
   str2 = 'none|sine|kaiser|gauss|blackmanharris';   

window_type_pop = uicontrol(fh,'Style', 'popup',... 
       'units','normalized',...
       'Value',1,...
       'String', str2,...
       'Position', [0.01 0.05 0.4 0.6]);
   
str3 = 'Fourier Transform|Inverse Fourier Transform';   
direction_type_pop = uicontrol(fh,'Style', 'popup',... 
       'units','normalized',...
       'Value',1,...
       'String', str3,...
       'Position', [0.4 0.35 0.55 0.6]);
OK_but = uicontrol(fh,'Style','pushbutton',...
       'String','OK',...
       'units','normalized',...
       'Position',[0.43 0.2 0.25 0.25],...
       'Callback',@OK_Callback);
cancel_but = uicontrol(fh,'Style','pushbutton',...
       'String','Cancel',...
       'units','normalized',...
       'Position',[0.68 0.2 0.25 0.25],...
       'Callback',@cancel_Callback);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%Callback Functions%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
    function OK_Callback(hObject,eventdata)
        switch get(ft_type_pop,'Value')
            case 1
                type = 'complex';
            case 2
                type = 'real';
            case 3
                type = 'imaginary';
            case 4 
                type = 'amplitude';
            case 5
                type = 'phase';
        end
        switch get(window_type_pop,'Value')
            case 1
                window = 'none';
            case 2
                window = 'sine';
            case 3
                window = 'kaiser';
            case 4
                window = 'gauss';
            case 5
                window = 'blackmanharris';
        end
        switch get(direction_type_pop,'Value')
            case 1
                direction = 'ft';
            case 2
                direction = 'ift';
        end
     new_data = fourier_transform2d(data,window,type,direction);
     new_data.ave = [];
     new_data.type = 3; % should already be set in fourier_transform2d
     new_data.var = [new_data.var '_' direction '_' type];
     new_data.ops{end+1} = ['Fourier Transform: ' type ' - ' window ' window - ' direction ' direction'];
     if strcmp(type,'complex')
         default_name = 'FT';
         answer = wrk_space_dialogue(default_name);
         if ~isempty(answer)
            assignin('base',answer{1},new_data)
        end
     else
        IMG(new_data);
     end
     display('New Data Created');
     close(fh);
    end
    function cancel_Callback(hObject,eventdata)
        new_data = '';
        close(fh);
    end
   
end
