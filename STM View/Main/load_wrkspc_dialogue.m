function name = load_wrkspc_dialogue
fh=figure('Name', 'Load Workspace Data',...
        'units','normalized', ...
        'Position',[0.3,0.3,0.18,0.2],...
        'Color',[0.6 0.6 0.6],...
        'MenuBar', 'none',...
        'NumberTitle', 'off',...
        'Resize','off');


data_names = evalin('base','who');
str = [data_names{1} '|'];
for i = 2:length(data_names)-1
    str = [str data_names{i} '|'];
end
str = [str data_names{end}];

name_pop = uicontrol(fh,'Style', 'popup',... 
       'units','normalized',...
       'Value',1,...
       'String', str,...
       'Position', [0.05 0.45 0.8 0.5]);
   
OK_but = uicontrol(fh,'Style','pushbutton',...
                          'String','OK',...
                          'units','centimeter',...
                          'Position',[4.7 2.3 1.5 0.7],...
                          'Callback',(@OK_Callback));
cancel_but = uicontrol(fh,'Style','pushbutton',...
                          'String','Cancel',...
                          'units','centimeter',...
                          'Position',[4.7 1.3 1.5 0.7],...
                          'Callback',(@cancel_Callback));

%%%%%%%%%%%%%%%%%%%%%%%%%%CALLBACK FUNCTIONS%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
uiwait(gcf); 
%halt execution of STM_View until this function returns a file to open

function OK_Callback(hObject,eventdata)
   val = get(name_pop,'Value');
   name = data_names{val};
   close(fh);
end
    function cancel_Callback(hObject,eventdata)
        name = [];
        close(fh);
    end
end