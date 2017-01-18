function MNQ_v_E(data,bragg_x,bragg_y)
[nr nc nz] = size(data.map);
x = data.e;
y = zeros(nz,1);
for k = 1:nz
    pk1 = data.map(bragg_x(2),bragg_x(1),k);
    pk2 = data.map(bragg_y(2),bragg_y(1),k);
    y(k) = (pk1 - pk2);
    
end
figure; plot(x,y);
end