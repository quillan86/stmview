function [data_T, data_out] = read_nanonis_3ds(fn)

[header, ndata, par, data_pos] = load3ds(fn);
if ~isstruct(header)
    display('Load Failed');
    return;
end

nr= header.grid_dim(1); 
nc= header.grid_dim(2);
nz = header.points;

new_map = zeros(nr,nc,nz);
topo = zeros(nr,nc);
fid = fopen(fn, 'r', 'ieee-be');    % open with big-endian
offset = data_pos; % position after which data is written
exp_size = header.experiment_size + header.num_parameters*4;

fseek(fid, offset, -1);
par = fread(fid, header.num_parameters, 'float');  
e = linspace(par(1),par(2),nz); % get energy vector

chnl_choice = choosechannel_dialogue(header.channels);
lr = header.points; % size of data matrix to read for every layer
lc = prod(size(header.channels));


for i = 1:nr %1:nr
    for j = 1:nc %1:nc
        pt_index = (i-1)*nr + (j-1);
        fseek(fid, offset + pt_index*exp_size, -1);
        par = fread(fid, header.num_parameters, 'float');        
        tmp = fread(fid, [lr lc], 'float'); 
        topo(i,j,:) = par(5);      
        if isempty(tmp) % fixes a bug where the last set of byes are empty in data file
            tmp = zeros(lr,lc);
        end
        new_map(i,j,:) = tmp(:,chnl_choice);                               
    end
end
%e = linspace(par(1),par(2),nz);

if strcmp(header.sweep_signal, 'Bias (V)')
    e = e*10^3; %convert from V to mV
elseif strcmp(header.sweep_signal,'Z (m)')
    e = e*10^12; %convert from m to pm
else 
    e = e*1; % for future cases when other sweep signal may be used
end

rx = linspace(0,header.grid_settings(3)*(10^9),nc);
ry = linspace(0,header.grid_settings(4)*(10^9),nr);
% 
%if data set is even number of pixel turn it into odd (better for FT symmetry
nx = length(rx); nx = nx + (mod(nx,2)-1);
ny = length(ry); ny = ny + (mod(ny,2)-1);
rx = rx(1:nx);
ry = ry(1:ny);

if nr == nc
    r = rx;
end

fn2 = fn(1:end-4);
fn2_parse = strsplit(fn2,{'/','/'}); %in case fn is directory
name = fn2_parse{end}; % the last cell contains the file name

data_out.map = new_map(1:ny,1:nx,:);
data_out.type = 100;
data_out.ave = avg_map(new_map);
data_out.name = name;
data_out.r = r;
data_out.coord_type = 'r';
data_out.e = e;
data_out.par = par;
data_out.info = header; 
data_out.ops = '';
data_out.var = 'dat';

%determine where dI/dV and I maps are stored from header.channels info
% these are well defined maps that will be treated differently .
I_channel = 100; % set to undefined channel
G_channel = 100;

 %if LIX ends up being used later will have to modify this code
for i = 1:length(header.channels)    
    switch header.channels{i}
        case 'Current (A)'
            I_channel = i;
        case 'LIY 1 omega (A)'
            G_channel = i;
    end
end
 
switch chnl_choice
    case I_channel
        data_out.map = data_out.map*(10^9); % scale current map to nA
        data_out.var = 'I';
        if strcmp(header.sweep_signal, 'Bias (V)');
            data_out.type = 1;  % if V spectroscopic current type = 1
        else
            data_out.type = 11; % current map with alt sweep parameter is type 11;
        end
    case G_channel
        % for when LI Y is recorded by bias mod is zero
        if isfield(header,'bias_mod')
            bias_mod = header.bias_mod;
        else
            bias_mod = 1;
        end
        data_out.map = data_out.map*(10^9)/bias_mod; %convert to conductance in nS
        data_out.var = 'G';
        if strcmp(header.sweep_signal,'Bias (V)');
            data_out.type = 0;  % if V spectroscopic current type = 1
        end       
end

data_T.map = polyn_subtract(topo(1:ny,1:nx,1)*(10^9),1); %convert m to nm
data_T.topo = topo(:,:,1);
data_T.type = 2;
data_T.ave = avg_map(topo);
data_T.name = name;
data_T.r = r;
data_T.coord_type = 'r';
data_T.e = 0;
data_T.par = par;
data_T.info = header;
data_T.ops = '';
data_T.var = 'T';

function choice = choosechannel_dialogue(channels)
        choice = 1;
        str = [channels{1} '|'];        
        for k = 2:length(channels)-1
            str = [str channels{k} '|'];           
        end
        str = [str channels{end} '|'];
        
        d = figure('Position',[300 300 250 150],...
            'Name','Channel Select',...
            'MenuBar', 'none',...
            'NumberTitle', 'off');
     
        txt = uicontrol('Parent',d,...
            'Style','text',...
            'Position',[20 80 210 40],...
            'String','Select Channel');
        
        popup1 = uicontrol('Parent',d,...
            'Style','popupmenu',...
            'Position',[10 70 230 25],...
            'String',str,...
            'Callback',@popup_callback); 
        
        btn = uicontrol('Parent',d,...
            'Position',[89 20 70 25],...
            'String','OPEN',...
            'Callback',@OK_Callback);
               
        % Wait for d to close before running to completion
        uiwait(d);
        
        function OK_Callback(hObject,eventdata)
            close(d);
            return;
        end
        function popup_callback(popup1,callbackdata)
            idx = popup1.Value;
            choice = idx;
        end
    end
end