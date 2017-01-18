function new_data = blur_map(data,pixel,std)

if isstruct(data)
    map = data.map;
else
    map = data;
end

h = fspecial('gaussian',std,pixel);
blur_map = imfilter(map,h,'replicate');

if isstruct(data)
    new_data = data;
    new_data.map = blur_map;
    new_data.ops{end+1} = ['Blur Map - pxl: ' num2str(pixel) ' std: ' num2str(std)];
else
    new_data = blur_map;
end
end