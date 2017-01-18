%% test BSCCO_gamma_pt
%G = G_disp_smooth;

%%
%y = avg_map(G.map);
r = 212; c = 65;
y = squeeze(squeeze(G70.map(r,c,:)));
x = G70.e*1000;
figure; plot(y);
peak_val_ind = find_gap_ind(GapMap_Neg_LF_02.map(r,c),x);
left_min_ind = 15;
min_val_ind = find(y(left_min_ind:peak_val_ind)==min(y(left_min_ind:peak_val_ind)));
min_val_ind = min_val_ind + left_min_ind - 1;
hold on; plot([peak_val_ind peak_val_ind], get(gca,'ylim'),'r');
hold on; plot([min_val_ind min_val_ind], get(gca,'ylim'),'g');
%%
%BSCCO_gamma_pt_v2(y,x,min_val_ind,peak_val_ind,4,0.1,100)
%A = BSCCO_gamma_pt(y,x,min_val_ind,peak_val_ind,4,0.1,100);
B = BSCCO_gamma_pt_v4(y,x,min_val_ind,peak_val_ind,3,0.3,100);
%C = BSCCO_gamma_pt_v3(y,x,min_val_ind,peak_val_ind,3,0.1,100);

%% test dip

BSCCO_dip_pt(y,x,peak_val_ind,10);
%%

r = 82;
c = 30;
y = squeeze(squeeze(G.map(r,c,1:45)));
x = G.e*1000;
figure; plot(x(1:45),y); hold on; 
plot([gamma_map(r,c) gamma_map(r,c)],get(gca,'ylim'),'r');
%%

findpeaks_4(x,y,0.0008,0,1,5)
%tic; findpeaks_3(x,y,0.0008,0,1,5); toc;