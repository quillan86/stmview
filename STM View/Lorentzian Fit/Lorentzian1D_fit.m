function Lorentzian1D_fit(z,x,init_param)

options = optimset('Display','off','TolFun',0.000001,'LargeScale','off');
param = fminunc(@fit_func,init_param,options,z,x);

figure; plot(x,Gaussian1D(x,param));
hold on; plot(x,z,'rx');
end
function z = fit_func(p,m,x)
Z = Lorentzian1D(x,p) - m;
z = sum(sum(Z.^2));
end
