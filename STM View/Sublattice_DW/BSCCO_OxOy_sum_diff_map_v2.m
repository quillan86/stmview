function [sum_Re_FTOxOy, sum_Im_FTOxOy, diff_Re_FTOxOy, diff_Im_FTOxOy, varargout] = BSCCO_OxOy_sum_diff_map_v2(data,re_psd_opt)

[Ox_map Oy_map Cu_map] = BSCCO_sublattice_maps(data);

Sum_map = Ox_map;
Sum_map.map = Ox_map.map + Oy_map.map;

Diff_map = Ox_map;
Diff_map.map = Ox_map.map - Oy_map.map;

%FT_OX = fourier_transform2d(Ox_map,'none','complex','ft');
%FT_OY = fourier_transform2d(Oy_map,'none','complex','ft');
FT_Cu_Re = fourier_transform2d(Cu_map,'none','real','ft');
FT_Cu_Im = fourier_transform2d(Cu_map,'none','imaginary','ft');

%initialize sum and diff maps
sum_Re_FTOxOy = fourier_transform2d(Sum_map,'none','real','ft');
sum_Re_FTOxOy.var = 'sum_Re_FTOxOy';
sum_Im_FTOxOy = fourier_transform2d(Sum_map,'none','imaginary','ft');
sum_Im_FTOxOy.var = 'sum_Im_FTOxOy';

diff_Re_FTOxOy = fourier_transform2d(Diff_map,'none','real','ft');
diff_Re_FTOxOy.var = 'diff_Re_FTOxOy';
diff_Im_FTOxOy = fourier_transform2d(Diff_map,'none','imaginary','ft');
diff_Im_FTOxOy.var = 'diff_Im_FTOxOy';

% sum_Re_FTOxOy.map = real(FT_OX.map) + real(FT_OY.map);
% sum_Im_FTOxOy.map = imag(FT_OX.map) + imag(FT_OY.map);
% 
% diff_Re_FTOxOy.map = real(FT_OX.map) - real(FT_OY.map);
% diff_Im_FTOxOy.map = imag(FT_OX.map) - imag(FT_OY.map);

if re_psd_opt == 1 % option for PSD as additional output
    psd_diff = diff_Re_FTOxOy;
    psd_diff.var = 'psd_diff_FTOxOy';
    psd_diff.map = sqrt((diff_Re_FTOxOy.map).^2 + (diff_Im_FTOxOy.map).^2);
    psd_sum = diff_Re_FTOxOy;
    psd_sum.var = 'psd_sum_FTOxOy';
    psd_sum.map = sqrt((sum_Re_FTOxOy.map).^2 + (sum_Im_FTOxOy.map).^2);    
    varargout{1} = psd_sum; varargout{2} = psd_diff;
elseif re_psd_opt == 2 % option for real space maps as output
    real_diff = Diff_map;
    real_diff.var = 'diff_OxOy';
    real_sum = Sum_map;
    real_sum.var = 'sum_OxOy';    
    varargout{1} = real_sum; varargout{2} = real_diff;
end