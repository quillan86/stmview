function param = fit_1Dgaussians(n,cut,lyr,p_init,pt1,pt2)
init_param = p_init;

w = 10;

offset = squeeze(mean(cut.cut(end-w:end,1)));
init_param(end) = offset;

param = init_param;
x = cut.r(pt1:pt2);   
x2 = linspace(x(1),x(end),length(x)*10);
options = optimset('Display','off','TolFun',0.000000001,'LargeScale','off');
z = cut.cut(pt1:pt2,lyr);
param(end) = squeeze(mean(z(end-w:end,1)));
param = fminunc(@fit_func,param,options,z,x,n);   

figure; 
GG = 0;
 for i = 1:n
     GG = Gaussian1D_basic(x2,[param((1+(i-1)*3):(3+(i-1)*3))]) + GG;
     plot(x2,Gaussian1D_basic(x2,[param((1+(i-1)*3):(3+(i-1)*3))]));
     hold on;
 end
 hold on; plot(x,z-param(end),'rx');
 hold on; plot(x2,GG,'k');
 title(['Energy: ' num2str(cut.e(lyr))]);
end
%param = Gaussian1D_fit(cut.cut(:,3),cut.r,[10 0.2 0.5 squeeze(mean(cut.cut(end-5:end))), 0]);
%figure; plot(pp(:,2),cut.e,'x');

function z = fit_func(p,m,x,n)
Z = 0;
for i = 1:n
    Z = Z + Gaussian1D_basic(x,[p((1+(i-1)*3):(3+(i-1)*3))]);
end
Z = Z + p(end);
Z = Z - m;
z = sum(sum(Z.^2));
end