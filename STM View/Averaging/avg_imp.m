function new_data = avg_imp(data,crd,w)

nz = size(data.map,3);
avg_map = zeros(2*w+1,2*w+1,nz);
new_data = data;
new_data.map = avg_map;
new_data.r = data.r(1:2*w+1);

for i = 1:size(crd,2);
    x = crd(i,1); y = crd(i,2);
    avg_map = avg_map + data.map(y-w:y+w,x-w:x+w,:);
end
avg_map = avg_map/(size(crd,2));
new_data.map = avg_map;
IMG(new_data);

end