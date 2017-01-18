function STM_View
%create main figure
fh=figure('Name', 'STM_View V 2.0',...
        'NumberTitle', 'off',...
        'units','centimeter', ...
        'Position',[1,5,10,5],...
        'Color',[0.5 0.5 0.5],...
        'MenuBar', 'none');
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Menu Bar%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
load_data = uimenu('Label','Load Data');

uimenu(load_data,'Label','Open Cornell File','Callback',@open_image_Callback);
uimenu(load_data,'Label','Open Nanonis File','Callback',@open_NN_Callback);
uimenu(load_data,'Label','Load from Workspace','Callback',@load_wrkspc_Callback);   
uimenu(load_data,'Label','TBD')

cpy_data = uimenu('Label','Copy Data','Callback',@copy_Callback);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    function open_image_Callback(hObject,source,eventdata)
        img_obj = read_map_v2;        
        if isempty(img_obj)
           disp('Load Failed');
           return;
        end        
        assignin('base',['obj_' img_obj.name '_' img_obj.var],img_obj);
        IMG(img_obj);
        
    end

function open_NN_Callback(hObject,source,eventdata)
        img_obj = read_map_NN;        
        if isempty(img_obj)
           disp('Load Failed');
           return;
        end                       
    end

    function load_wrkspc_Callback(hObject,eventdata)       
        str = load_wrkspc_dialogue;
        if ~isempty(str)
            img_obj = evalin('base',str);
            IMG(img_obj);
        end
    end

    function copy_Callback(hObject,eventdata)
        copy_data_dialogue;
    end
end