function dDW_amplitude(Ox_map,Oy_map,Q1,Q2,Q3,Q4,width)
%Q1 = [477 431]; Q2 = [431 477];
%Q3 = [477 477]; Q2 = [431 431];

[nr nc nz] = size(Ox_map.map);
FT_Ox = fourier_transform2d(Ox_map,'none','complex','ft');
FT_Oy = fourier_transform2d(Oy_map,'none','complex','ft');

diff_FT = FT_Ox.map- FT_Oy.map;


gauss_mask1 = Gaussian(1:nr,1:nc,width,Q1,1);%+ Gaussian(1:nr,1:nc,width,Q2,1);
gauss_mask2 = Gaussian(1:nr,1:nc,width,Q3,1);%+ Gaussian(1:nr,1:nc,width,Q4,1);

for i = 1:nz
    diff_FT_mask1(:,:,i) = diff_FT(:,:,i).*gauss_mask1;
    diff_FT_mask2(:,:,i) = diff_FT(:,:,i).*gauss_mask2;
end


diff_FT_mask1_IFT = (fourier_transform2d(diff_FT_mask1,'none','complex','ift'));
diff_FT_mask2_IFT = (fourier_transform2d(diff_FT_mask2,'none','complex','ift'));

img_plot2(abs(diff_FT_mask1_IFT(:,:,1)))
img_plot2(abs(diff_FT_mask2_IFT(:,:,1)))
img_plot2((abs(diff_FT_mask1_IFT(:,:,1))-abs(diff_FT_mask2_IFT(:,:,1)))./(abs(diff_FT_mask1_IFT(:,:,1))+abs(diff_FT_mask2_IFT(:,:,1))))
%img_plot2(gauss_mask1);
%img_plot2(gauss_mask2);
