%%
map = Z_MNR_lnorm_escale.map;
[nr nc nz] = size(map);
correl = zeros(1,nz);
for i = 1:nz
    correl(i) = ncorr2(map(:,:,i),nem_img_DeltaNR_pos);
end
figure; plot(G_MNR_lnorm.e,correl);
clear nr nc nz correl
%%
Z_disp_mod = Z_disp;
[nr nc nz] = size(Z_disp.map);
for k=1:nz
    tmp = Z_disp_mod.map(:,:,k);
    tmp(A) = 0;
    Z_disp_mod.map(:,:,k) = tmp;
end
clear nr nc nz tmp
%%
map = G_MNR_lnorm_tile_escale.map;
map = Z_MNR_lnorm_tile_escale.map;
[nr nc nz]= size(map);
correl = zeros(1,nz);
for i = 1:nz
    tmp = map(:,:,i);
    mean_val(i) = mean(mean(tmp(tmp~=0)));
end
figure; plot(G_MNR_lnorm.e,mean_val);
clear nr nc nz tmp