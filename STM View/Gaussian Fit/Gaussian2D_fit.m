function param = Gaussian2D_fit(img,x,y,init_param)

% param(1) = A
% param(2) = x0
% param(3) = y0
% param(4) = sigma_x
% param(5) = sigma_y
% param(6) = theta (in radians)
% param(7) = constant background
% param(8) = linear coefficient
options = optimset('Display','off','TolFun',0.000001,'LargeScale','off');
param = fminunc(@fit_func,init_param,options,img,x,y);

% F = Gaussian2D(x,y,param);
% %img_plot2(F); 
% figure; surf(F); shading flat; alpha(0.3);
% hold on; img_scatter_plot(img,0.0)

end
function z = fit_func(p,m,x,y)
x
y
p
m
Z = Gaussian2D(x,y,p) - m;
z = sum(sum(Z.^2));
end