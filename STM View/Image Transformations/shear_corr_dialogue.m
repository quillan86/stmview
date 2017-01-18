function shear_corr_dialogue(data,varargin)
fh=figure('Name', 'Shear Correction - Enter Bragg Peak Indices',...
        'units','normalized', ...
        'Position',[0.3,0.3,0.18,0.1],...
        'Color',[0.6 0.6 0.6],...
        'MenuBar', 'none',...
        'NumberTitle', 'off',...
        'Resize','off');

uicontrol(fh,'Style','text',...
    'units','normalized',...
    'String','Q1x',...
       'Position', [0.05 0.85 0.2 0.15]);
bragg1x = uicontrol(fh,'Style', 'edit',... 
       'units','normalized',...              
       'Position', [0.05 0.58 0.2 0.25],...
        'String','50');

uicontrol(fh,'Style','text',...
    'units','normalized',...
    'String','Q1y',...
       'Position', [0.05 0.35 0.2 0.15]);
bragg1y = uicontrol(fh,'Style','edit',...
        'units','normalized',...
        'Position',[0.05 0.08 0.2 0.25],...
        'String','50');

uicontrol(fh,'Style','text',...
    'units','normalized',...
    'String','Q2x',...
    'Position', [0.35 0.85 0.2 0.15]);  
bragg2x = uicontrol(fh,'Style', 'edit',... 
       'units','normalized',...              
       'Position', [0.35 0.58 0.2 0.25],...
       'String','-50');

uicontrol(fh,'Style','text',...
    'units','normalized',...
    'String','Q2y',...
       'Position', [0.35 0.35 0.2 0.15]);  
bragg2y = uicontrol(fh,'Style','edit',...
        'units','normalized',...
        'Position',[0.35 0.08 0.2 0.25],...
        'String','50');
   
    
OK_but = uicontrol(fh,'Style','pushbutton',...
       'String','Transform',...
       'units','normalized',...
       'Position',[0.7 0.6 0.25 0.25],...
       'Callback',@OK_Callback);

 cancel_but = uicontrol(fh,'Style','pushbutton',...
       'String','DONE',...
       'units','normalized',...
       'Position',[0.7 0.25 0.25 0.25],...
       'Callback',@cancel_Callback);
  
%%%%%%%%%%%%%%%%%%%%%%%%CALLBACK FUNCTIONS%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    function OK_Callback(hobject,eventdata)
        pt1(1) = str2num(get(bragg1x,'String'));
        pt1(2) = str2num(get(bragg1y,'String'));
        pt2(1) = str2num(get(bragg2x,'String'));
        pt2(2) = str2num(get(bragg2y,'String'));
        new_img = linear2D_image_correct(pt1,pt2,data);
        new_data = data;
        new_data.map = new_img;
        new_data.ave = [];
        new_data.var = [new_data.var '_shear_cor'];
        new_data.ops{end+1} = ['Shear Correction: Bragg Peaks (' num2str(pt1(1)) ' ' num2str(pt1(2)) ', (' num2str(pt2(1)) ' ' num2str(pt2(2))];
        IMG(new_data);
        display('New Data Created');
        %close(fh);
    end
    function cancel_Callback(hObject,eventdata)       
        close(fh);
    end
end