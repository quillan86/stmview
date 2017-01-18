function QPI_data = YRS_QPI(path_root,filename)
%path_root = 'C:\Data\stm data\RUN067\YRS\130711\';
G = read_map_no_dialogue([filename '.2FL'], path_root);
I = read_map_no_dialogue([filename '.1FL'], path_root);
G = current_divide2(G,I);
[nr nc nz] = size(G.map);
% calculate average power in each  real space layer before being
% processed - this sets a more definitive normalization value for bilateral filter      

for i = 1:nz
    mval(i) = abs(mean(mean(G.map(:,:,i))))*nr*nc;
end

G = polyn_subtract(G,2);
G_FT = fourier_transform2d(G,'none','amplitude','ft');
%G_FT = map_rotate(G_FT,-2);
G_FT = symmetrize_image_v2(G_FT,'vd');
G_FT_bfilt = G_FT;
old_map = G_FT.map;
h = waitbar(0,'Applying bilateral filter to Layers...');
set(h,'Name','Bilateral Filter Progress');       
for i = 1:nz           
           img = old_map(:,:,i);
           max_val = mval(i);
           new_map(:,:,i) = bilateral_filt(img/max_val,5,[1.5 0.0005])*max_val;
           waitbar(i/nz,h,[num2str(i/nz*100) '%']);
end
close(h);
G_FT_bfilt.map = new_map;
clear nc nc nz img old_map new_map

old_map = G_FT_bfilt.map;
new_map = rm_center(old_map,4);
G_FT_bfilt.map = new_map;

clear old_map clear new_map
QPI_data = G_FT_bfilt;
img_obj_viewer2(QPI_data);
end