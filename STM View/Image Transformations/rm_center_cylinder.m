function new_data = rm_center_cylinder(data,radius)

if isstruct(data)
    img = data.map;
else
    img = data;
end
[nr nc nz] = size(img);

if mod(nr,2) == 0
    cr = nr/2 + 0.5;
else 
    cr = nr/2;
end

if mod(nc,2) == 0
    cc = nc/2 + 0.5;
else 
    cc = nc/2;
end
x = 1:nc; x = x - cc;
y = 1:nr; y = y - cr;

[X Y] = meshgrid(x,y);

R = sqrt(X.^2 + Y.^2);
R(R <= radius) = 0;
R(R > radius) =1;

for k = 1:nz
    new_img(:,:,k) = img(:,:,k).*R;
end

if isstruct(data)
    new_data = data;
    new_data.map = new_img;    
else
    new_data = new_img;    
end
end