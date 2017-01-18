function [data] = read_nanonis_sxm(fn,varargin)

%fn = '/Users/MHamidian/Documents/Research/STM Data/Harvard/Test.sxm';

%just read the header first
[header, ndata, data_pos] = loadsxm(fn);
if ~isstruct(header)
    display('Load Failed');
    return;
end

% determine how many channels were recorded in sxm file (stupid file)
% this information is contained in header.data_info as a string
ind = strfind(header.data_info,';'); %index after which channel information starts
di = header.data_info(ind+2:end); % only keep string containing string info
DI = strsplit(di); % split each word into a cell of an array

% each channel has 6 cells in DI so can determine how many channels are
% recorded

num_channels = size(DI,2)/6 - 1; % substract 1 because first 6 cells are headers
%channels = zeros(num_channels,1);
for i = 1:num_channels % find channel names & find if they are both fwd and bkwd
    channels{i} = DI{8 + 6*(i-1)}; %first channel names starts at index 8
    direction{i} = DI{10 + 6*(i-1)}; %first direction starts at index 10
end

% use varargin to import proper channel or ask user

if nargin > 1
    channel_choice = varargin(1);
else
    channel_choice = choosechannel_dialogue(channels);
end
fid = fopen(fn, 'r', 'ieee-be'); 
offset = data_pos + 4;
im_nr = channel_choice-1; %0 indexed
sizen = prod(header.scan_pixels)*4;   % 4 Bytes per pixel
fseek(fid, offset + im_nr*sizen, -1);

pix = header.scan_pixels;
map = fread(fid, [pix(1) pix(2)], 'float');
map = transpose(map);

% assign map type
channel_type = (channel_choice - mod(channel_choice,2))/2;
channel = channels{channel_type+1};
switch channel
    case 'Z'
        type = 2;
        vari = 'T';
        nrm = 10^9; % convert from m to nm        
    case 'Current'
        type = 3;
        vari = 'IF';
        nrm = (10^9); %convern to nA
    case 'LIY_1_omega';
        type = 4;
        vari = 'LIY';
        nrm = (10^9)/(header.bias_mod); %need to divide LIY by bias mod to get cond
    case 'LIY_n_omega';
        type = 5;
        vari = 'LIYn';
        nrm = (10^9)/(header.bias_mod); %need to divide LIY by bias mod to get cond
    otherwise
        type = 100;
        vari = 'Q';
        nrm = 1;
end 

%construct position vector
rx = linspace(0,header.scan_range(1)*(10^9),header.scan_pixels(1));
ry = linspace(0,header.scan_range(2)*(10^9),header.scan_pixels(2));

%set name for object data
fn2 = fn(1:end-4);
fn2_parse = strsplit(fn2,{'/','/'}); %in case fn is directory
name = fn2_parse{end}; % the last cell contains the file name

%if data set is even number of pixel turn it into odd (better for FT symmetry
nx = length(rx); nx = nx + (mod(nx,2)-1);
ny = length(ry); ny = ny + (mod(ny,2)-1);
map = map(1:ny,1:nx,:);
rx = rx(1:nx);
ry = ry(1:ny);

% construct STM_View data structure
data.map = map*nrm;
data.type = type;
data.ave = avg_map(map);
data.name = name;
data.r = rx;
data.rx = rx;
data.ry = ry;
data.coord_type = 'r';
data.e = 0;
data.info = header; 
data.ops = '';
data.var = vari;

    function choice = choosechannel_dialogue(channels)
        choice = 100;
        str = [channels{1} ':fwd'  '|'];
        str = [str channels{1} ':bkwd' '|'];
        for i = 2:length(channels)-1
            str = [str channels{i} ':fwd' '|'];
            str = [str channels{i} ':bkwd' '|'];
        end
        str = [str channels{end} ':fwd' '|'];
        str = [str channels{end} ':bkwd' '|'];
        
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
            'Position',[75 70 100 25],...
            'String',str,...
            'Callback',@popup_callback); 
        
        btn = uicontrol('Parent',d,...
            'Position',[89 20 70 25],...
            'String','Accept',...
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
