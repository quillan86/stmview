%%%%%%%
% CODE DESCRIPTION:  remove or only keep pixels from original map with
%                    Gaussian envelope
%
% INPUT:            - number of peaks is arbitrary pk_pos = (x,y)
%                     in pixels coordinates and is nx2 matrix.  
%                   - Same number of widths must be given as number of
%                     points, pk_w
%                   - for removing areas around peaks use type = 0
%                   - for only keeping area around peaks use type = 1
%                   
% CODE HISTORY
%
% 20151210 MHH  Created
%
%
%%%%%%%

function new_data = guass_mask(data,pk_pos,pk_w,type)

if isstruct(data) % check if data is a full data structure
    [nr,nc,nz]=size(data.map);
    img = data.map;
else % single data image
    [nr,nc,nz] = size(data);
    img = data;
end

n = size(pk_pos,1);
mask = zeros(nr,nc);
for i = 1:n
    mask = mask + Gaussian2D(1:nr,1:nc,pk_w(i),pk_w(i),0,[pk_pos(i,1) pk_pos(i,2)],1);
end
if type == 0 % remove points around pkpos
    mask = 1 - mask;
    str = 'subt';
elseif type == 1 % keep points around pkpos
    mask = mask;
    str = 'add';
else
    display('Incorrect type')
    return;    
end
%img_plot2(mask);

tmp_img = zeros(nr,nc,nz);

for k = 1:nz
    tmp_img(:,:,k) = img(:,:,k).*mask;
end

if isstruct(data)
    new_data = data;
    new_data.map = tmp_img;
    
    new_data.var = [new_data.var '_gauss_mask'];
    new_data.ops{end+1} = ['Gaussian mask w/ pk_pos and pk_w, type:' str ' FT type: ' FT_type];
    new_data.pk_pos = pk_pos;
    new_data.pk_w = pk_w;
    IMG(new_data);
else
    new_dadta = tmp_data;
end

end
