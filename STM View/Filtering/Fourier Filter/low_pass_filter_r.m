function low_pass_filter_r(data,width)

if isstruct(data)
    img = data.map;
else
    img = data;
end

[nr, nc, nz] = size(img);

ft_img = fourier_transform2d(img,'none','complex','ft');
%img_plot2(abs(ft_img));
filt = Gaussian2D(1:nr,1:nc,width,width,0,[round(nr/2) round(nc/2)],1);
%img_plot2(filt);
for i = 1:nz
    filt_ft(:,:,i) = ft_img(:,:,i).*filt;    
    filt_img(:,:,i) = fourier_transform2d(filt_ft(:,:,i),'none','real','ift');
end

if isstruct(data)
    new_data = data;
    new_data.map = filt_img;
    new_data.ops{end+1} = ['Low Pass Gaussian Filter ' num2str(width) ' pixel wdith'];
    new_data.ave = avg_map(filt_img);
    new_data.var = [new_data.var '_LPF'];
    IMG(new_data);
else
    varargout = filt_img;
end
end