function Z = Lorentzian2D(x,y,param)
A = param(1);
x0 = param(2);
y0 = param(3);
sigma_x = param(4);
sigma_y = param(5);
theta = param(6); % in radians
const = param(7);
lin_x = param(8);
lin_y = param(9);
a = cos(theta)^2/2/sigma_x^2 + sin(theta)^2/2/sigma_y^2;
b = -sin(2*theta)/4/sigma_x^2 + sin(2*theta)/4/sigma_y^2;
c = sin(theta)^2/2/sigma_x^2 + cos(theta)^2/2/sigma_y^2;
 const = 0;
 lin_x = 0;
 lin_y = 0;
[X,Y] = meshgrid(x,y);
Z = A./(1 + a*(X-x0).^2 + b*(X-x0).*(Y-y0) + c*(Y-y0).^2) + const + lin_x*X + lin_y*Y;
%img_plot2(Z);
end