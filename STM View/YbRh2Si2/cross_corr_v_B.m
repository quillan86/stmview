clear ac;
clear max_val max_val_ind
map1 = G_100mT_30mK_crop.map;
map2 = G_25mT_30mK_crop.map;

nz1 = size(map1,3);
nz2 = size(map2,3);

for i = 1:min(nz1,nz2)
    for j = 1:min(nz1,nz2)
        ac(i,j) = max(max(normxcorr2(map1(:,:,i),map2(:,:,j))));
    end
end
%img_plot2(ac);
%colormap(jet);
%clear i j nz1 nz2     
for i = 1:min(nz1,nz2)
    max_val_ind(i) = find(ac(i,:) == max(ac(i,:)));
    max_val(i) = max(ac(i,:));
end
figure; plot(max_val);
figure; plot(max_val_ind);