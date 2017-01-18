function [param, gof] = fano_fit(x,y)
fano_line = 'a*((x - e)/g + q)^2/(1 + ((x - e)/g)^2) + b*x^2 + c*x + d';

s = fitoptions('Method','NonlinearLeastSquares',...
    'Startpoint',[0.2 0.0 0 0.1 50 50 1],...
    'Algorithm','Levenberg-Marquardt',...
    'TolX',1e-4,...
    'MaxIter',5000,...
    'MaxFunEvals', 5000);

f = fittype(fano_line,'options',s);
[p,gof] = fit(x,y,f);
param = p;

x2 = min(x):0.01:max(x);
y2 = p.a*((x2 - p.e)/p.g + p.q).^2./(1 + ((x2 - p.e)/p.g).^2) + p.b*x2.^2 + p.c*x2 + p.d;
figure;
plot(x2,y2)
hold on; plot(x,y,'rx');
end
