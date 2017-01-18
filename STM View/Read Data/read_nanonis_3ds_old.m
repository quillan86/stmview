function [data_T, data_I, data_G] = read_nanonis_3ds_old(fn)

%fn = '/Users/MHamidian/Documents/Research/STM Data/Harvard/2013-05-18_T20B-1_Grid Spectroscopy001.3ds';
[header, ndata, par, data_pos] = load3ds(fn);
if ~isstruct(header)
    display('Load Failed');
    return;
end

nr= header.grid_dim(1); 
nc= header.grid_dim(2);
nz = header.points;

topo = zeros(nr,nc);
mapG = zeros(nr,nc,nz);
mapI = zeros(nr,nc,nz);
fid = fopen(fn, 'r', 'ieee-be');    % open with big-endian
offset = data_pos; % position after which data is written
exp_size = header.experiment_size + header.num_parameters*4;

%determine where dI/dV and I maps are stored from header.channels info
I_channel = 100; % set to undefined channel
G_channel = 100;
for i = 1:length(header.channels)    
    switch header.channels{i}
        case 'Current (A)'
            I_channel = i;
        case 'LIY 1 omega (A)'
            G_channel = i;
    end
end

for i = 1:nr
    for j = 1:nc
        pt_index = (i-1)*nr + (j-1);
        fseek(fid, offset + pt_index*exp_size, -1);
        par = fread(fid, header.num_parameters, 'float');        
        tmp = fread(fid, [header.points prod(size(header.channels))], 'float'); 
        topo(i,j,:) = par(5);
        if G_channel == 100 %if not G-channel recorded then output zero
            mapG(i,j,:) = 0;
        else
            mapG(i,j,:) = tmp(:,G_channel);
        end
        if I_channel == 100
            mapI(i,j,:) = 0;
        else
            mapI(i,j,:) = tmp(:,I_channel);        
        end
    end
end
e = linspace(par(1),par(2),nz);
rx = linspace(0,header.grid_settings(3)*(10^9),nc);
ry = linspace(0,header.grid_settings(4)*(10^9),nr);

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

data_I.map = mapI(1:ny,1:nx,:)*(10^9);
data_I.type = 1;
data_I.ave = avg_map(mapI);
data_I.name = name;
data_I.r = r;
data_I.coord_type = 'r';
data_I.e = e;
data_I.par = par;
data_I.info = header; 
data_I.ops = '';
data_I.var = 'I';

data_G.map = mapG(1:ny,1:nx,:)*(10^9)/header.bias_mod; %convert to conductance in nS
data_G.type = 0;
data_G.ave = avg_map(mapG);
data_G.name = name;
data_G.r = r;
data_G.coord_type = 'r';
data_G.e = e;
data_G.par = par;
data_G.info = header;
data_G.ops = '';
data_G.var = 'G';

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
end