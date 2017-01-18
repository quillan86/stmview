function z = Gaussian1D(x,param)
A = param(1);
x0 = param(2);
sigma_x = param(3);
const = param(4);
lin_x = param(5);

a = 0.5/sigma_x^2;
b = 1/(sigma_x*sqrt(2*pi));
z = A*b*exp(-(a*(x-x0).^2)) + const + 0*lin_x*x;


end