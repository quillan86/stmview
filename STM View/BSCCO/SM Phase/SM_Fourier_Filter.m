function new_data = SM_Fourier_Filter(data,Q1,Q2,width)

if isstruct(data)
    [nr,nc,nz] = size(data.map);
    img = data.map;
else
    [nr,nc,nz] = size(data);
    img = data;
end

F_img = fourier_transform2d(img,'none','complex','ft');

%img_plot2(abs(F_topo));
% Q = [y x] in pixels
gauss_mask = Gaussian(1:nr,1:nc,width,Q1,1) + Gaussian(1:nr,1:nc,width,Q2,1);
%img_plot2(gauss_mask);
F_topo_mask = zeros(nr,nc,nz);
for k = 1:nz
    F_topo_mask(:,:,k) = F_img(:,:,k).*gauss_mask;
end
%img_plot2(abs(F_topo_mask));
new_img = real(fourier_transform2d(F_topo_mask,'none','complex','ift'));
%img_plot2(real(new_topo));
%img_plot2((topo));
if isstruct(data)
    new_data = data;
    new_data.map = new_img;
    new_data.ops{end+1} = 'SM Filter';
else    
    new_data = new_img;
end



end