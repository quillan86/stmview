function new_data = rm_center(data,sigma)

if isstruct(data)
    img = data.map;
else
    img = data;
end
[nr nc nz] = size(img);

if mod(nr,2) == 0
    cr = nr/2 + 1;
else 
    cr = nr/2 + 0.5;
end

if mod(nc,2) == 0
    cc = nc/2 + 1;
else 
    cc = nc/2 + 0.5;
end
gauss_filt = Gaussian_v2(1:nr,1:nc,sigma,sigma,0,[cr cc],1);
new_img = zeros(nr,nc,nz);
for k = 1:nz
    new_img(:,:,k) = img(:,:,k) - gauss_filt.*img(:,:,k);
end
if isstruct(data)
    new_data = data;
    new_data.map = new_img;    
else
    new_data = new_img;    
end

end