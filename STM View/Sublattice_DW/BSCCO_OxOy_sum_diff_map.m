function [sum_Re_FTOxOy, sum_Im_FTOxOy, diff_Re_FTOxOy, diff_Im_FTOxOy, varargout] = BSCCO_OxOy_sum_diff_map(data,psd_opt)

[Ox_map Oy_map Cu_map] = BSCCO_sublattice_maps(data);

FT_OX = fourier_transform2d(Ox_map,'none','complex','ft');
FT_OY = fourier_transform2d(Oy_map,'none','complex','ft');
FT_Cu_Re = fourier_transform2d(Cu_map,'none','real','ft');
FT_Cu_Im = fourier_transform2d(Cu_map,'none','imaginary','ft');

%initialize sum and diff maps
sum_Re_FTOxOy = FT_OX;
sum_Re_FTOxOy.var = 'sum_Re_FTOxOy';
sum_Im_FTOxOy = FT_OY;
sum_Im_FTOxOy.var = 'sum_Im_FTOxOy';

diff_Re_FTOxOy = FT_OX;
diff_Re_FTOxOy.var = 'diff_Re_FTOxOy';
diff_Im_FTOxOy = FT_OY;
diff_Im_FTOxOy.var = 'diff_Im_FTOxOy';

sum_Re_FTOxOy.map = real(FT_OX.map) + real(FT_OY.map);
sum_Im_FTOxOy.map = imag(FT_OX.map) + imag(FT_OY.map);

diff_Re_FTOxOy.map = real(FT_OX.map) - real(FT_OY.map);
diff_Im_FTOxOy.map = imag(FT_OX.map) - imag(FT_OY.map);

if psd_opt == 1
    psd_diff = diff_Re_FTOxOy;
    psd_diff.var = 'psd_diff_FTOxOy';
    psd_diff.map = sqrt((diff_Re_FTOxOy.map).^2 + (diff_Im_FTOxOy.map).^2);
    psd_sum = diff_Re_FTOxOy;
    psd_sum.var = 'psd_sum_FTOxOy';
    psd_sum.map = sqrt((sum_Re_FTOxOy.map).^2 + (sum_Im_FTOxOy.map).^2);    
    varargout{1} = psd_sum; varargout{2} = psd_diff;
end