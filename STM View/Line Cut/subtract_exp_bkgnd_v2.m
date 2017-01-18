function [y_new] = subtract_exp_bkgnd_v2(y,x,x_fit)
%x = 1:length(y); 
x = x';
init_guess = [10000 -1 1 2 ];
exp_bkgn = 'a*exp(b*x^c) + d';

s = fitoptions('Method','NonlinearLeastSquares',...
    'Startpoint',[init_guess],...
    'Algorithm','Levenberg-Marquardt',...
    'TolX',1e-8,...
    'MaxIter',10000,...
    'MaxFunEvals', 10000);

f = fittype(exp_bkgn,'options',s);

[p,gof] = fit(x,y,f);
y_new = feval(p,x_fit);
p
end