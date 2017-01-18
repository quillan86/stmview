function new_img = nematic_tile(img,pixels)
n = pixels;
[nr nc] = size(img);
new_img = zeros(nr,nc);
[r c] = find(img ~= 0);
for i = 1:length(r)
    new_img(r(i)-n:r(i)+n,c(i)-n:c(i)+n) = img(r(i),c(i));
end
    

