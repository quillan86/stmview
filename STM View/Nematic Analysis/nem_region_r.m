function nem_region_r(q_px,filt_w,data)
FT_data = fourier_transform2d(data,'none','complex','ft');

[nr, nc, nz] = size(data.map);    
mask1 = Gaussian2D(1:nr,1:nc,filt_w,filt_w,0,[q_px(1,1) q_px(2,1)],1);
mask2 = Gaussian2D(1:nr,1:nc,filt_w,filt_w,0,[q_px(1,2) q_px(2,2)],1); 

map = FT_data.map;
map_mask1 = zeros(nr,nc,nz);
map_mask2 = zeros(nr,nc,nz);
for k = 1:nz
    map_mask1(:,:,k) = map(:,:,k).*mask1;
    map_mask2(:,:,k) = map(:,:,k).*mask2;
end

FT_data_mask1 = FT_data; FT_data_mask1.map = map_mask1;
FT_data_mask2 = FT_data; FT_data_mask2.map = map_mask2;

data_mask1 = fourier_transform2d(FT_data_mask1,'none','amplitude','ift'); 
data_mask2 = fourier_transform2d(FT_data_mask2,'none','amplitude','ift'); 

data_mask1.var = 'x-dir regions';
data_mask2.var = 'y-dir regions';

nem = data_mask1;
nem.var = 'xdir_subt_ydir';
nem.map = (data_mask1.map - data_mask2.map);%./(data_mask1.map + data_mask2.map);
IMG(nem);
%IMG(data_mask1);
%IMG(data_mask2);
end