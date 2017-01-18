%%
r = 210; c = 58;
y = squeeze(G_cor.map(r,c,:));
x = G_cor.e*1000;
%figure; plot(x,y)
tic; [sgap dgap] = BSCCO_UD_gap_edge_find_basic(30,300,y,x); toc;
%tic; BSCCO_UD_gap_edge_find(y,x); toc;%
%%
dgap_refine_v2(r,c) = 0.078;
%%
gap_view(G_crop_LFCorrect_shear_cor_crop_LFCorrect,dgap_basic,173,113);
%%
[r_ov c_ov] = find(dgap_basic >=0.200 & dgap_basic <= 0.3);
[r_un c_un] = find(dgap_basic <=0.055 & dgap_basic > 0);

figure; imagesc(dgap_basic);
for i = 1:length(r_ov)
    hold on; plot(c_ov(i),r_ov(i),'x')
end
%%
n = 134;
%gap_view(G_crop_LFCorrect_shear_cor_crop_LFCorrect,dgap_basic,r_ov(n),c_ov(n))
y = squeeze(G_crop_LFCorrect_shear_cor_crop_LFCorrect.map(r_ov(n),c_ov(n),:));
x = G_crop_LFCorrect_shear_cor_crop_LFCorrect.e*1000;
BSCCO_UD_gap_edge_find_basic(y,x); 
%tic; BSCCO_UD_gap_edge_find(y,x); toc;
%%
[s d] = BSCCO_UD_gap_edge_find_basic(y,x);
dgap_basic3(r_ov(n),c_ov(n)) = d;
n
%% put zeros on the egdges of map which were 300mV before
dgap_basic2 = dgap_basic;
for i = 1:212
    for j = 1:3
        gap_val = dgap_basic2(i,j);
        if gap_val >=0.299
            dgap_basic2(i,j) = 0;
        end
    end
end

for j = 1:212
    for i = 209:212
        gap_val = dgap_basic2(i,j);
        if gap_val >=0.299
            dgap_basic2(i,j) = 0;
        end
    end
end
figure; imagesc(dgap_basic2);

%%
dgap_basic3 = dgap_basic2;
x = G_crop_LFCorrect_shear_cor_crop_LFCorrect.e*1000;
for i = 1:length(c_ov)
    y = squeeze(G_crop_LFCorrect_shear_cor_crop_LFCorrect.map(r_ov(i),c_ov(i),:));    
    [new_gap_val_s new_gap_val_d] =  BSCCO_UD_gap_edge_find(y,x);
    dgap_basic3(r_ov(i),c_ov(i)) = new_gap_val_d;
end
    