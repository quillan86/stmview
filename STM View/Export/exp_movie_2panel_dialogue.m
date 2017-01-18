function exp_movie_2panel_dialogue(current_obj_handle)

h1 = figure(...
'Units','characters',...
'Color',[0.941176470588235 0.941176470588235 0.941176470588235],...
'MenuBar','none',...
'Name','2 Panel Movie Set Up',...
'NumberTitle','off',...
'Position',[50 30 114.428571428571 22.25],...
'Resize','off',...
'Visible','on');


img1_title = uicontrol(...
'Parent',h1,...
'Units','characters',...
'BackgroundColor',[1 1 1],...
'Position',[7 17.55 35.8571428571429 1.2],...
'String',{  'Static Text' },...
'Style','text');

img1_axes = axes(...
'Parent',h1,...
'Units','characters',...
'Position',[7 4.65 35.8571428571429 12.55]);
axis off

wrkspc_sel = uicontrol(...
'Parent',h1,...
'Units','characters',...
'BackgroundColor',[1 1 1],...
'Position',[71.2857142857143 19.4 35.8571428571429 1.6],...
'String',{'GUI Workspace'},...
'Style','popupmenu',...
'Value',2,...
'Callback',@wrkspc_sel_Callback);

struct_sel = uicontrol(...
'Parent',h1,...
'Units','characters',...
'BackgroundColor',[1 1 1],...
'Position',[71.4285714285714 17.6 35.8571428571429 1.6],...
'String',{  '' },...
'Style','popupmenu',...
'Value',1,...
'Callback',@struct_sel_Callback);


accept_but = uicontrol(...
'Parent',h1,...
'Units','characters',...
'Position',[44.5714285714286 0.6 9.85714285714285 1.7],...
'String','EXPORT',...
'Callback',@accept_Callback);

done_but = uicontrol(...
'Parent',h1,...
'Units','characters',...
'Position',[59.2857142857143 0.6 9.85714285714285 1.7],...
'String','Done',...
'Callback',@done_Callback);



img1_lyrs = uicontrol(...
'Parent',h1,...
'Units','characters',...
'BackgroundColor',[1 1 1],...
'Position',[18.2857142857143 1.60000000000001 13.5714285714286 1.5],...
'String',{  '' },...
'Style','popupmenu',...
'Value',1,...
'Callback',@plot_img1_Callback);

 uicontrol(...
'Parent',h1,...
'Units','characters',...
'Position',[15.8571428571429 3.1 17.7142857142857 0.95],...
'String','Layer - Image 1',...
'Style','text');



%%%%%%%%%%%%%%%%%%%%%%%% MAIN - Initialize %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Cmap = load_min_colormaps; Cmap = Cmap.Blue2;
% get data from call object and load it into gui
current_obj = guidata(current_obj_handle);
color_lim = get(current_obj_handle,'UserData');
set(img1_lyrs,'String', num2str(1000*current_obj.e','%10.2f'))
plot_img1_Callback
set(img1_title,'String',[current_obj.name '_' current_obj.var])
% on initialization show data objects in global workspace
wrkspc_vars = find_obj_wrkspc;
if isempty(wrkspc_vars)
    set(struct_sel,'String','[empty]');
    set(struct_sel,'Value',1);
else
    set(struct_sel,'String',find_obj_wrkspc);
    struct_sel_Callback
end


%%%%%%%%%%%%%%%%%%%%%% CALLBACK FUNCTIONS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function plot_img1_Callback(hObject,eventdata)
       colormap(Cmap);
       data = guidata(current_obj_handle);
       layer=get(img1_lyrs,'Value'); 
       color_lim = get(current_obj_handle,'UserData');
       color_lim = color_lim(layer,:);       
       axes(img1_axes);
       imagesc((data.map(:,:,layer)));               
       axis off; axis equal; shading flat;       
       caxis(color_lim);
end

function plot_img2_Callback(hObject,eventdata)
   colormap(Cmap);
   data = get(img2_axes,'UserData');
   layer = get(img2_lyrs,'Value');
   axes(img2_axes);
   imagesc((data.map(:,:,layer)));               
   axis off; axis equal; shading flat;       
   set(img2_axes,'UserData',data);
end

function wrkspc_sel_Callback(hObject,eventdata)
    
    sel_val = get(wrkspc_sel,'Value');
    if sel_val == 1
        struct_names = find_obj_wrkspc; 
        if isempty(struct_names)
            set(struct_sel,'String','[empty]')
            set(struct_sel,'Value',1);
            axes(img2_axes);            
            imagesc([0 0 ; 0 0]);
            axis off; axis equal;
            return;
        end
    else
        obj_handles = find_obj_gui(current_obj_handle);
        if isempty(obj_handles)
            set(struct_sel,'String','[empty]')
            set(struct_sel,'Value',1);
            axes(img2_axes);            
            imagesc([0 0 ; 0 0]);
            axis off; axis equal;
            return;
        end
        for i = 1:length(obj_handles)
            struct_names{i} = get(obj_handles(i),'Name');
        end
    end        
    set(struct_sel,'String',struct_names);
    set(struct_sel,'Value',1);
    set(img2_lyrs,'Value',1);
    struct_sel_Callback
end

function struct_sel_Callback(hObject,eventdata)
    wrkspc = get(wrkspc_sel,'Value');
    
    if wrkspc == 1
        data_name = get(struct_sel,'String');
        data = evalin('base',data_name{get(struct_sel,'Value')});        
    else
        obj_handles = find_obj_gui(current_obj_handle);
        strct_num = get(struct_sel,'Value');
        data = guidata(obj_handles(strct_num));
    end
    set(img2_axes,'UserData',data);
    set(img2_lyrs,'String', num2str(1000*data.e','%10.2f'))
    set(img2_lyrs,'Value',1);
    plot_img2_Callback   
   set(img2_axes,'UserData',data);
end

function done_Callback(hObject,eventdata)
   delete(h1) 
end

function accept_Callback(hObject,eventdata)
    if strcmp(get(struct_sel,'String'), '[empty]')
        display('Second data set missing');
        return;
    end
    
    ops_val = get(ops_sel,'Value');
    data2 = get(img2_axes,'UserData');
    [nr1 nc1 nz1] = size(current_obj.map);
    [nr2 nc2 nz2] = size(data2.map);
    if nr1 ~= nr2 || nc1 ~= nc2
        display('Size mismatch between images to be correlated');
        display('Unable to complete operation');
        return;
    end
    new_data = make_struct;
    new_data.var = 'CC';
    new_data.type = 3;
    new_data.r = current_obj.r;
    if ops_val == 1
        layer_current_obj = get(img1_lyrs,'Value');
        layer_data2 = get(img2_lyrs,'Value');            
        new_data.name = [current_obj.name '_c' num2str(layer_current_obj) '_c' num2str(layer_data2) '_' data2.name];            
        new_data.map = norm_xcorr2d(current_obj.map(:,:,layer_current_obj),data2.map(:,:,layer_data2));
    elseif ops_val == 2
       layer_current_obj = get(img1_lyrs,'Value');
       new_data.name = [current_obj.name '_c' num2str(layer_current_obj) '_cn' data2.name];           
       new_data.map = zeros(nr1,nc1,nz2);
       for k = 1:nz2
           new_data.map(:,:,k) = norm_xcorr2d(current_obj.map(:,:,layer_current_obj),data2.map(:,:,k));
       end
       new_data.e = data2.e;
    else
        layer_data2 = get(img2_lyrs,'Value');
        new_data.name = [current_obj.name '_cn_c' num2str(layer_data2) '_' data2.name];
        new_data.map = zeros(nr1,nc1,nz1);
        for k = 1:nz1
           new_data.map(:,:,k) = norm_xcorr2d(current_obj.map(:,:,k),data2.map(:,:,layer_data2));
        end
        new_data.e = current_obj.e;
    end     
    %varargout{1} = new_data;
    img_obj_viewer2(new_data);
end

end
