function param = Lorentzian2D_fit(img,x,y,init_param)

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
% 
% F = Lorentzian2D(x,y,param);
% figure('Position',[300 200 900 800]); surf(F); shading flat; alpha(0.3);
% hold on; img_scatter_plot(img,0.0)
% daspect([0.5,0.5,1]);
% zlim([0,50]);
% OptionZ.FrameRate=15;OptionZ.Duration=15;OptionZ.Periodic=true;
% CaptureFigVid([-20,10;-110,10;-190,80;-290,10;-380,10], 'Lorentz',OptionZ)


end
function z = fit_func(p,m,x,y)
Z = Lorentzian2D(x,y,p) - m;
z = sum(sum(Z.^2));
% A = p(1);
% x0 = p(2);
% y0 = p(3);
% sigma_x = p(4);
% sigma_y = p(5);
% theta = p(6);
% 
% a = cos(theta)^2/2/sigma_x^2 + sin(theta)^2/2/sigma_y^2;
% b = -sin(2*theta)/4/sigma_x^2 + sin(2*theta)/4/sigma_y^2;
% c = sin(theta)^2/2/sigma_x^2 + cos(theta)^2/2/sigma_y^2;
% 
% Z = A./(1 + a*(X-x0).^2 + b*(X-x0).*(Y-y0) + c*(Y-y0).^2) - m;
% z = sum(sum(Z.^2));
end