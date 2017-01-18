function new_data = polyn_subtract(data,order)

if isstruct(data)
    map = data.map;
    rx = data.r;
    ry = data.r;
else
    map = data;
    ry = 1:size(map,1);
    rx = 1:size(map,2);
end
%[nr nc nz] = size(data.map);
[nr nc nz] = size(map);
w = ones(nr,nc);
new_map = zeros(nr,nc,nz);
for i = 1:nz
    %p(i,:) = polyfitweighted2(data.r,data.r,data.map(:,:,i),order,w);
    %new_map(:,:,i) = data.map(:,:,i) - polyval2(p(i,:),data.r,data.r);
    p(i,:) = polyfitweighted2(ry,rx,map(:,:,i),order,w);
    new_map(:,:,i) = map(:,:,i) - polyval2(p(i,:),ry,rx);
end

if isstruct(data);
    new_data = data;
    new_data.map = new_map;
    new_data.ave = avg_map(data.map);
    new_data.var = [new_data.var '_' num2str(order) '_polysub'];
    new_data.ops{end+1} = [num2str(order) ' order background subtraction'];
    display('New Data Created');
else
    new_data = new_map;
end
end