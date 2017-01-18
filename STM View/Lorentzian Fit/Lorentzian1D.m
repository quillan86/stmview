function z = Lorentzian1D(x,param)
A = param(1);
x0 = param(2);
sigma_x = param(3);
const = param(4);
lin_x = param(5);

a = 1/2/sigma_x^2;

z = A./(1 + a*(x-x0).^2) + const + lin_x*x;
end