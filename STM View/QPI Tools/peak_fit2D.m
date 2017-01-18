function param = peak_fit2D(x0,y0,A,std_x,std_y,angle_dgrs,const,lin_x,lin_y,window_w,img,peak_type)
[nr,nc] = size(img);

% make sure width of window doesn't go beyond size of image and if so
% adjust
x1 = max(1,x0-window_w);
x2 = min(nc,x0+window_w);
y1 = max(1,y0-window_w);
y2 = min(nr,y0+window_w);

x = x1:x2;
y = y1:y2;
angle_rad = angle_dgrs*pi/180; % convert angles to radians
[X,Y] = meshgrid(x,y);
img_crop = img(y1:y2,x1:x2); % take the parts of the image defined the widow width

if peak_type == 1
    param = Gaussian2D_fit(img_crop,x,y,[A x0 y0 std_x std_y angle_rad const lin_x lin_y]);
    F = Gaussian2D(x,y,param);
    figure('Position',[300 200 800 700]); surf(F); shading flat; alpha(0.3);
    hold on; img_scatter_plot(img_crop,[0 0 0])
elseif peak_type == 2;
    param = Lorentzian2D_fit(img_crop,x,y,[A x0 y0 std_x std_y angle_rad const lin_x lin_y]);
    F = Lorentzian2D(x,y,param);
    figure('Position',[300 200 800 700]); surf(F); shading flat; alpha(0.3);
    hold on; img_scatter_plot(img_crop,[0 0 0])
else
    display('No valid peak type defined.  Choose 1 or 2');
    param = [];
    return;
end

end