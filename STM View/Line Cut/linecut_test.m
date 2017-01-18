%%
a = copper(length(cut.e));
%a = copper(11);
%%
%cut = cut3;
figure; 
%for i = length(cut.e):-1:1
for i = 8:12
    
plot(cut.r,cut.cut(:,i)+i*0.0,'color',a(i,:)); hold on;
end
xlim([0.0 0.6]);
%%
figure; imagesc(cut.r,cut.e,((cut.cut(:,:)')));
set(gca,'YDir','normal')

ylim([-0.004 -0.001]);
xlim([0.05 0.5]);
colormap(Cmap.Invgray)
%colormap(Cmap.Defect1)
colormap(jet)
%%
B = bilateral_filt(img,10,[5 0.1]);
%%
%img_plot2(img,Cmap.Defect1); caxis([0.01 0.15])
img_plot2(B,Cmap.Defect1);caxis([0.01 0.15])
%%
for i = 1:57
    TT.map(:,:,
    TT.map(:,:,i) = ones
end
 img_obj_viewer2(TT)
 %%
 for i = 1:39
     yy(i) = FT_gap_map(112+i,112-i);
 end
 figure; plot(yy)
 %%
 figure; plot(cut(:,1))
 for i = 2:10
     hold on; plot(cut(:,i));
 end