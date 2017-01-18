function [y_new, p] = subtract_exp_bkgnd(y)
x = 1:length(y); x = x';
init_guess = [1000 -1 1 1 ];
exp_bkgn = 'a*exp(b*x^c) + d';

s = fitoptions('Method','NonlinearLeastSquares',...
    'Startpoint',[init_guess],...
    'Algorithm','Levenberg-Marquardt',...
    'TolX',1e-6,...
    'MaxIter',10000,...
    'MaxFunEvals', 10000);

f = fittype(exp_bkgn,'options',s);

[p,gof] = fit(x,y,f);
y_new = feval(p,x);
p
end