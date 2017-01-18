function new_img = crop_img(img,x1,x2,y1,y2)
[nr nc nz] = size(img);
new_img = zeros(abs(x1-x2)+1,abs(y1-y2)+1,nz);
size(new_img)

%minx = max(1,x1); miny = max(1,y1);
%maxx = min(nc,x2); maxy = min(nr,y2);
for k = 1:nz
    new_img(:,:,k) = img(x1:x2,y1:y2,k);
   % new_img(:,:,k) = img(minx:maxx,miny:maxy,k);
end
end