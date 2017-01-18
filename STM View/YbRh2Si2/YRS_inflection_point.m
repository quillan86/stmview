%% YbRh2Si2 infleciton point

y = obj_30605A02_G.ave;
x = obj_30605A02_G.e*1000;
y = squeeze(squeeze(obj_30605A02_G.map(20,30,:)));
%figure; plot(x,y);

y2 = y(10:end);
x2 = x(10:end);
p = polyfit(x2,y2',7);
y_fit = polyval(p,x2);
figure; plot(x,y,'b'); 
hold on; plot(x(10:end),y_fit,'r');
figure; plot(x(3:end-2),num_der2b(2,y))

%%
map1 =  G_25mT_25mK_FT_bfilt.map;
map2 = G_25mT_200mK_FT_bfilt.map;
map1 = data1.map;
map2 = data2.map;
for i = 1:17
    map1(:,:,i) = map1(:,:,i)/abs(max(max(map1(:,:,i))));
    map2(:,:,i) = map2(:,:,i)/abs(max(max(map2(:,:,i))));
end
diff_map = map2 - map1;
diff_data.map = diff_map;