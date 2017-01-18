function outmaps =  dDW(data)

load RedWhiteBlue
cols = RedWhiteBlue;

[nr nc nz] = size(data.map);
Ox_pos = data.Ox;
Oy_pos = data.Oy;
Cu_pos = data.Cu;


Ox_pos2 = zeros(nr,nc);
Oy_pos2 = zeros(nr,nc);
Cu_pos2 = zeros(nr,nc);
width = 0;
for i = 2:nr-1
    for j = 2:nc-1
        if Ox_pos(i,j) ==1
            min_i = max(i-width,1);
            max_i = min(i+width,nr);
            min_j = max(j-width,1);
            max_j = min(j+width,nc);
            Ox_pos2(min_i:max_i,min_j:max_j) = 1;
        end
        if Oy_pos(i,j) ==1
            min_i = max(i-width,1);
            max_i = min(i+width,nr);
            min_j = max(j-width,1);
            max_j = min(j+width,nc);
            Oy_pos2(min_i:max_i,min_j:max_j) = 1;
        end
        if Cu_pos(i,j) ==1
            min_i = max(i-width,1);
            max_i = min(i+width,nr);
            min_j = max(j-width,1);
            max_j = min(j+width,nc);
            Cu_pos2(min_i:max_i,min_j:max_j) = 1;
        end
    end
end
%img_plot2(Ox_pos2);
%img_plot2(Oy_pos2);
Ox_map = data;
Oy_map = data;
Cu_map = data;
for k = 1:nz    
    Ox_map.map(:,:,k) = data.map(:,:,k).*Ox_pos2;        
    Oy_map.map(:,:,k) = data.map(:,:,k).*Oy_pos2;
    Cu_map.map(:,:,k) = data.map(:,:,k).*Cu_pos2;
end
%tX = Ox_map.map(:,:,1);
%tY = Oy_map.map(:,:,1);
%[fh1 nX xX] = histogram(tX(tX~=0),30);
%[fh2 nY xY] = histogram(tY(tY~=0),30);
%close(fh1);
%close(fh2);
%figure; 
%plot(xX,nX,'r.'); hold on;
%plot(xY,nY,'b.'); hold on;
%[pX gX] = fit_Gaussian1D(xX,nX');
%[pY gy] = fit_Gaussian1D(xY,nY');
%plot(pX,'r'); hold on; plot(pY,'b');
Ox_map.var = 'Ox_map';
Oy_map.var = 'Oy_map';
Cu_map.var = 'Cu_map';

FT_OX = fourier_transform2d(Ox_map,'none','imaginary','ft');
FT_OY = fourier_transform2d(Oy_map,'none','imaginary','ft');
FT_Cu_real = fourier_transform2d(Cu_map,'none','real','ft');
FT_Cu_imag = fourier_transform2d(Cu_map,'none','imaginary','ft');

img_obj_viewer2(FT_OX);
img_obj_viewer2(FT_OX);

%initialize sum and diff maps
sum_Re_FTOxOy = FT_OX;
sum_Im_FTOxOy = FT_OY;
diff_Re_FTOxOy = FT_OX;
diff_Im_FTOxOy = FT_OY;

sum_Re_FTOxOy.map = real(FT_OX.map) + real(FT_OY.map);
sum_Im_FTOxOy.map = imag(FT_OX.map) + imag(FT_OY.map);

diff_Re_FTOxOy.map = real(FT_OX.map) - real(FT_OY.map);
diff_Im_FTOxOy.map = imag(FT_OX.map) - imag(FT_OY.map);



img_obj_viewer2(sum_Re_FTOxOy); colormap(cols);
img_obj_viewer2(sum_Im_FTOxOy); colormap(cols);
%img_obj_viewer2(FT_Cu_real);
%img_obj_viewer2(FT_Cu_imag);

%img_obj_viewer2(Ox_map);
%img_obj_viewer2(Oy_map);

end