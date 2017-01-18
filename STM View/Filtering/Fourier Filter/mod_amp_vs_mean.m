%%%%%%%
% CODE DESCRIPTION:  Generate real space image of fourier filtered image
%                    and its mean value map 
%
% INPUT:            - number of peaks is arbitrary pk_pos = (qx,qy)
%                     in pixels coordinates and is nx2 matrix.  
%                   - Same number of widths must be given as number of
%                     points, pk_w%                   
%                     
% CODE HISTORY
%
% 20150914 MHH  Created
%
%
%%%%%%%
function mod_amp_vs_mean(data,pk_pos,pk_w)
[nr,nc,nz] = size(data.map);

new_data_mod = fourier_filter(data,pk_pos,pk_w,1);
data_avg = zeros(1,nz);
mod_avg = zeros(1,nz);

for i = 1:nz
    data_avg(i) = mean(mean(data.map(:,:,i)));
    mod_avg(i) = mean(mean(new_data_mod.map(:,:,i)));
end
figure; plot(data_avg,'gx');
figure; plot(mod_avg,'x');
figure; plot(data.e*1000,mod_avg./data_avg*100,'rx');

IMG(new_data_mod);




end