function MNQ_E(data,pt1,pt2,width)
map = data.map; e = data.e*1000; w = width;
nz = size(map,3);
mnq = zeros(1,nz);
a = zeros(1,nz);
b = zeros(1,nz);
for i = 1:nz
    a(i) = sum(sum(map(pt1(2)-w:pt1(2)+w,pt1(1)-w:pt1(1)+w,i)));
    b(i) = sum(sum(map(pt2(2)-w:pt2(2)+w,pt2(1)-w:pt2(1)+w,i)));
    mnq(i) = abs(a(i) - b(i));%/((a(i)+b(i))/2);
end
figure; plot(e,mnq,'k');
xlabel('Energy'); ylabel('MNQ');

figure;
plot(e,a,'b');
hold on; plot(e,b,'r');
xlabel('Energy'); ylabel('MNQ');
end