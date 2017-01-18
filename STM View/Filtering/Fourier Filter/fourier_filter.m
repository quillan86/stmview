%%%%%%%
% CODE DESCRIPTION:  take real space data and peak positionsin q-space and 
%                    filters additivel or subtractively

% INPUT:            - number of peaks is arbitrary pk_pos = (qx,qy)
%                     in pixels coordinates and is nx2 matrix.  
%                   - Same number of widths must be given as number of
%                     points, pk_w
%                   - for removing q-modulation use type = 0
%                   - for only keeping q-modulation use type = 1
%                   - FT_type is real, amplitude,imaginary (string)

% CODE HISTORY
%
% 20150914 MHH  Created
%
%
%%%%%%%

function new_data = fourier_filter(data,pk_pos,pk_w,type,FT_type)

if isstruct(data) % check if data is a full data structure
    [nr,nc,nz]=size(data.map);
    FT_data = fourier_transform2d(data,'none','complex','ft');
    img = FT_data.map;
else % single data image
    [nr,nc,nz] = size(data);
    img = fourier_transform2d(data,'none','complex','ft');
end

n = size(pk_pos,1);
mask = zeros(nr,nc);
for i = 1:n
    mask = mask + Gaussian2D(1:nr,1:nc,pk_w(i),pk_w(i),0,[pk_pos(i,1) pk_pos(i,2)],1);
end
if type == 0 % remove q-modulations
    mask = 1 - mask;
    str = 'subt';
elseif type == 1 % keep only q-modulation
    mask = mask;
    str = 'add';
else
    display('Incorrect type')
    return;    
end
%img_plot2(mask);

tmp_data = zeros(nr,nc,nz);

for k = 1:nz
    tmp_data(:,:,k) = img(:,:,k).*mask;
end

if isstruct(data) % check if data is a full data structure
    FT_data_filt = FT_data;
    FT_data_filt.map = tmp_data;
    new_data = fourier_transform2d(FT_data_filt,'none',FT_type,'ift');
    new_data.var = [new_data.var '_Ffilt'];
    new_data.ops{end+1} = ['Fourier Filer w/ pk_pos and pk_w, type:' str ' FT type: ' FT_type];
    new_data.pk_pos = pk_pos;
    new_data.pk_w = pk_w;
    IMG(new_data);
else  
    new_data = fourier_transform2d(tmp_data,'none',FT_type,'ift');
end




%filt_img = fourier_transform2d(filt_ft,'none','complex','ift');

% if isstruct(data)
%     new_data.map = tmp_data;
% else
%     new_data = tmp_data;
% end