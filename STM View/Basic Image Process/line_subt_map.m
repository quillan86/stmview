function new_data = line_subt_map(data,ord)

if isstruct(data)
    img = data.map;
else
    img = data;
end

[nr,nc,nz] = size(img);
new_img = zeros(nr,nc,nz);
for k = 1:nz
    for i = 1:nr
        new_img(i,:,k) = img(i,:,k) - mean(mean(img(i,:,k)));
    end
end
  
if isstruct(data)
   new_data = data;
   new_data.map = new_img;
   new_data.ops{end+1} = 'line subraction';
   new_data.var = [new_data.var '_ln_subt'];
else
    new_data = new_img;
end

end