function [data_filt_Q1 data_filt_Q2 data_filt_Q1Q2] = QPI_r_amplitude(q_px,filt_w,data)
[nr nc nz] = size(data.map);
mask1 = Gaussian2D(1:nr,1:nc,filt_w,filt_w,0,[q_px(1,1) q_px(2,1)],1);
mask2 = Gaussian2D(1:nr,1:nc,filt_w,filt_w,0,[q_px(1,2) q_px(2,2)],1);   

FT_data = fourier_transform2d(data,'none','complex','ft');
FT_data_filt_Q1 = FT_data;
FT_data_filt_Q2 = FT_data;
for k = 1:nz
    FT_data_filt_Q1.map = FT_data.map(:,:,k).*mask1;
    FT_data_filt_Q2.map = FT_data.map(:,:,k).*mask2;
end
data_filt_Q1 = fourier_transform2d(FT_data_filt_Q1,'none','amplitude','ift');
data_filt_Q2 = fourier_transform2d(FT_data_filt_Q2,'none','amplitude','ift');
data_filt_Q1Q2 = data_filt_Q1;
data_filt_Q1Q2.map = data_filt_Q1.map + data_filt_Q2.map;

img_obj_viewer2(data_filt_Q1Q2);
end