function SM_phase_dialogue(data,obj_handle)
fh=figure('Name', 'SM Phase Map',...
        'units','normalized', ...
        'Position',[0.3,0.3,0.3,0.1],...
        'Color',[0.6 0.6 0.6],...
        'MenuBar', 'none',...
        'NumberTitle', 'off',...
        'Resize','off');

uicontrol(fh,'Style','text',...
    'units','normalized',...
    'String','SM - Q1x (upper)',...
       'Position', [0.01 0.85 0.19 0.15]);
p1x = uicontrol(fh,'Style', 'edit',... 
       'units','normalized',...              
       'Position', [0.05 0.58 0.12 0.25],...
        'String','1');

uicontrol(fh,'Style','text',...
    'units','normalized',...
    'String','SM - Q1y (upper)',...
       'Position', [0.01 0.35 0.19 0.15]);
p1y = uicontrol(fh,'Style','edit',...
        'units','normalized',...
        'Position',[0.05 0.08 0.12 0.25],...
        'String','1');

uicontrol(fh,'Style','text',...
    'units','normalized',...
    'String','SM - Q2x (lower)',...
    'Position', [0.21 0.85 0.19 0.15]);  
p2x = uicontrol(fh,'Style', 'edit',... 
       'units','normalized',...              
       'Position', [0.25 0.58 0.12 0.25],...
       'String','1');

uicontrol(fh,'Style','text',...
    'units','normalized',...
    'String','SM - Q2y (lower)',...
       'Position', [0.21 0.35 0.19 0.15]);  
p2y = uicontrol(fh,'Style','edit',...
        'units','normalized',...
        'Position',[0.25 0.08 0.12 0.25],...
        'String','1');
   
uicontrol(fh,'Style','text',...
    'units','normalized',...
    'String','Filter Width',...
    'Position', [0.45 0.55 0.12 0.15]);
filt_width = uicontrol(fh,'Style','edit',...
    'units','normalized',...
    'Position',[0.45 0.25 0.12 0.25],...
    'String','5');
    
OK_but = uicontrol(fh,'Style','pushbutton',...
       'String','OK',...
       'units','normalized',...
       'Position',[0.7 0.6 0.25 0.25],...
       'Callback',@OK_Callback);

 done_but = uicontrol(fh,'Style','pushbutton',...
       'String','DONE',...
       'units','normalized',...
       'Position',[0.7 0.25 0.25 0.25],...
       'Callback',@done_Callback);
  
%%%%%%%%%%%%%%%%%%%%%%%%CALLBACK FUNCTIONS%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    function OK_Callback(hobject,eventdata)
        q_px(1,1) = str2num(get(p1x,'String'));
        q_px(2,1) = str2num(get(p1y,'String'));
        q_px(1,2) = str2num(get(p2x,'String'));
        q_px(2,2) = str2num(get(p2y,'String'));
        filt_w = str2num(get(filt_width,'String'));
        phase = SM_phase(data.map,[q_px(2,1) q_px(1,1)],[q_px(2,2) q_px(1,2)],filt_w);    
        new_data = data; 
        new_data.SM_phase = phase;        
        new_data.SM_phase_info = ['X1 = ' num2str(q_px(1,1)) ' Y1 = ' num2str(q_px(2,1))...
                                            '; X2 = ' num2str(q_px(1,2)) ' Y2 = ' num2str(q_px(2,2))...
                                            '; Filter Width = ' num2str(filt_w)];
        guidata(obj_handle,new_data)
        
    end
    function done_Callback(hObject,eventdata)       
        close(fh);
    end
end
