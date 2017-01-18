function varargout = autocorr_dialogue(data)
if isstruct(data)     
    img = data.map;
else      
    img = data;
end

[nr, nc, nz] = size(img);
acorr_img = zeros(nr,nc,nz);
for k = 1:nz
    acorr_img(:,:,k) = norm_xcorr2d(img(:,:,k),img(:,:,k));
end

if isstruct(data)
    new_data = data;
    new_data.map = acorr_img;   
    new_data.var = 'AC';
    new_data.ops{end+1} = ['Autocorrelation of ' data.name '_' data.var];
    varargout{1} = new_data;
    IMG(new_data);
else
    varargout{1} = acorr_img;
end


end