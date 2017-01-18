function new_data = gauss_blur_image(data,pixel,std)

h = fspecial('gaussian',std,pixel);
%h = fspecial('disk',pixel);

blur_map = imfilter(data.map,h,'replicate');
new_data = data;
new_data.map = blur_map;

end