function varargout = MNQ_R(data,pt1,pt2,filt_width,varargin)
% [117 71] 
% [71 71]

if isstruct(data)
    %k = r_to_k_coord(data.r);
    map = data.map;
    r = data.r;
else
    if ~isempty(varargin)
        r = varargin{1};
        map = data;
    end
end
[nr nc nz] = size(map);
k = r_to_k_coord(r);
x = r;
y = x;

[X Y] = meshgrid(x,y);

Qx = k(pt1);
Qy = k(pt2);
cosx =cos(Qx(1)*X + Qx(2)*Y);
cosy =cos(Qy(1)*X + Qy(2)*Y);

filter = Gaussian2D(k,k,filt_width,filt_width,0,[0 0],1);
%filter = 1;
%img_plot2(filter);
fx = zeros(nr,nc,nz);
fy = zeros(nr,nc,nz);
for i = 1:nz  
    fx(:,:,i) = fourier_transform2d(map(:,:,i).*cosx,'none','real','ft');
    fy(:,:,i) = fourier_transform2d(map(:,:,i).*cosy,'none','real','ft');
end
%img_plot2(-fx);
%img_plot2(-fy);
%img_plot2(filter);
nematic_Q = fx - fy;
%img_plot2(nematic_Q);
nematic_R = zeros(nr,nc,nz);
%img_plot2((filter.*nematic_Q));
for i = 1:nz
    nematic_R(:,:,i) = fourier_transform2d(nematic_Q(:,:,i).*filter,'none','complex','ift');
end
%img_plot2(real(nematic_R));
if isstruct(data)
    new_data = data;
    new_data.map = nematic_R;
    new_data.var = [new_data.var '_MNQ(r)'];
    new_data.ops = {};
    new_data.ave = [];
    img_obj_viewer2(new_data);
else
    varargout{1} = nematic_R;
end