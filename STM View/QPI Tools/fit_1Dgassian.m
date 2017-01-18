function fit_1Dgassian(n,cut)



[nr,nc] = size(cut.cut);
%for i = 1:nc
%    plot(cut.r,cut.cut(:,i)); hold on;
%end

%plot(cut.r,cut.cut(:,1));
z = cut.cut(:,1);
x = cut.r;
A = eye(3*n);
b = zeros(3*n,1);

init_param = [0.5 0.1 0.1 0.5 0.4 0.1 squeeze(mean(cut.cut(end-5:end)))];


options = optimset('Display','off','TolFun',0.000000001,'LargeScale','off');
param = fminunc(@fit_func,init_param,options,z,x,n);
%param = fmincon(@fit_func,init_param,A,b,options,z,x,n);
param
figure; 
GG = 0;
for i = 1:n
    GG = Gaussian1D_basic(x,[param((1+(i-1)*3):(3+(i-1)*3))]) + GG;
    plot(x,Gaussian1D_basic(x,[param((1+(i-1)*3):(3+(i-1)*3))]));
    hold on;
end
hold on; plot(x,z-param(end),'rx');
hold on; plot(x,GG,'k');

%param = Gaussian1D_fit(cut.cut(:,3),cut.r,[10 0.2 0.5 squeeze(mean(cut.cut(end-5:end))), 0]);

end

function z = fit_func(p,m,x,n)
Z = 0;
for i = 1:n
    Z = Z + Gaussian1D_basic(x,[p((1+(i-1)*3):(3+(i-1)*3))]);
end
Z = Z + p(end);
Z = Z - m;
z = sum(sum(Z.^2));
end