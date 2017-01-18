%%
nr = 111;
nc = 50;
sm = 0.2;
x = G.e(27:end)*1000;
%y = squeeze(G.map(nr,nc,17:end));
y = squeeze(G_LFCorrect_shear_cor_crop_LFCorrect.map(nr,nc,27:52));
[gap_val pk_mag dbl_pk_check] = BSCCO_OD_gap(y,x,sm,1,0.1,0);
%% Od80
gmaps_LF_sm = BSCCO_gap_map_v2(G_LFCorrect_shear_cor_crop_LFCorrect,27,52,0.2,[0 0 1],0,0.1,0);
%% OD70
gmaps_LF_sm = BSCCO_gap_map_v2(G_crop_LFCorrect_shear_cor_crop_LFCorrect,27,52,0.2,[0 0 1],0,0.0,0);