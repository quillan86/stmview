function new_data = crop_dialogue(data,varargin)
varargin{:}
if isstruct(data)
    [nr nc nz] = size(data.map);
    img = data.map;
else
    [nr nc nz] = size(data);
    img = data;
end
if nargin < 2
    prompt = {'Upper Left Corner - x:','Upper Left Corner - y:','Lower Right Corner - x:', 'Lower Right Corner - y:'};
    dlg_title = 'Coordinates for Square Crop Area';
    num_lines = 1;
    default_answer = {'1','1','1','1'};
    confirm = 0;
    while 1
        answer = inputdlg(prompt,dlg_title,num_lines,default_answer);
        if isempty(answer)
            return;
        end
        if abs(str2double(answer{1}) - str2double(answer{3})) == ...
                                abs(str2double(answer{2}) - str2double(answer{4}))
            break;
        else
            display('Not Square Coordinates - Try Again');    
        end
    end
    x1 = str2double(answer{1}); x2 = str2double(answer{3}); 
    y1 = str2double(answer{2}); y2 = str2double(answer{4});
else
    x = varargin{1}; y = varargin{2};
    x1 = x(1); x2 = x(2);
    y1 = y(1); y2 = y(2);
end

new_img = crop_img(img,y1,y2,x1,x2);

if isstruct(data)
    new_data = data;
    new_data.map = new_img;
    new_data.ave = squeeze(mean(mean(new_img)));
    new_data.r = data.r(1:(x2-x1)+1);
    new_data.var = [new_data.var '_crop'];
    new_data.ops{end+1} = ['Crop:' num2str(x1) ' ,' num2str(y1) ':' num2str(x2) ' ,' num2str(y2)];
    
    if isfield(new_data,'phase_map')        
        new_data.phase_map.theta1=crop_img(data.phase_map.theta1,y1,y2,x1,x2);
        new_data.phase_map.theta2=crop_img(data.phase_map.theta2,y1,y2,x1,x2);
        new_data.phase_map.s_phase1=crop_img(data.phase_map.s_phase1,y1,y2,x1,x2);
        new_data.phase_map.s_phase2=crop_img(data.phase_map.s_phase2,y1,y2,x1,x2);
        new_data.phase_map.theta1_old=crop_img(data.phase_map.theta1_old,y1,y2,x1,x2);
        new_data.phase_map.theta2_old=crop_img(data.phase_map.theta2_old,y1,y2,x1,x2);        
    end
    
    if isfield(new_data,'Cu') && isfield(new_data,'Ox') && isfield(new_data,'Oy')
        new_data.Cu=crop_img(data.Cu,y1,y2,x1,x2);
        new_data.Ox=crop_img(data.Ox,y1,y2,x1,x2);
        new_data.Oy=crop_img(data.Oy,y1,y2,x1,x2);
        if isfield(new_data,'Cu_index');
            new_data = rmfield(new_data,{'Cu_index','Ox_index1','Ox_index2',...
                                       'Oy_index1','Oy_index2'});
        end
    end
    
     IMG(new_data);
else
    new_data = new_img;
end
display('New Data Created');
end