function z = Gaussian1D_basic(x,param)
A = param(1);
x0 = param(2);
sigma_x = param(3);

a = 0.5/sigma_x^2;
%b = 1/(sigma_x*sqrt(2*pi));
%z = A*b*exp(-(a*(x-x0).^2));
z = A*exp(-(a*(x-x0).^2));


end