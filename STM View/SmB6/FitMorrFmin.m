clear xFinal fitFinal dataFinal

% dataOrigin need to be global too. 
global colum;
global energies;

% set fitting range here
energies = [-25:60];
%energiesAll = [-60:60];
energiesAll = [-100:100];
for colum = 1:1

% x [ rc rf Ef v tf/tc slope intercept]

A = [-1 0 0 0 0 0 0;
     0 -1 0 0 0 0 0;
     0 0 0 0 0 0 0;
     0 0 0 -1 0 0 0;
     0 0 0 0 0 0 0;
     0 0 0 0 0 0 0;
     0 0 0 0 0 0 0;];
 b = [0; 0; 0; 0; 0; 0; 0;];

% use fmincon to fit, one can change the initial values
in_con1 = [1,2.83,-5.084,113.35,-0.002109, 0.003688, 1.3919];
in_con2 = [1,3,-3.5,80,-0.023,0.0035,-0.4];
options = optimoptions('fmincon','MaxFunEvals',3000);
[x,fval] = fmincon(@Residual,in_con1,A,b,[],[],[],[],[],options);


[~,sizeE] = size(energies);

data = dataOrigin(:,colum);
[sized,~] = size(data);

%data = data([sized-sizeE+1:sized]);
data = data/data(sized);
%%
fit = MorrSpec(1,x(2),x(3),x(4),x(5),energies);
fit = fit/fit(sizeE);

mismatch = [0:sizeE-1];
mismatch = mismatch * x(6)+x(7);
fit = fit + mismatch;

dataFinal(:,colum) = data;
fitFinal (:,colum) = fit;
xFinal (colum,:) = x;
%%
figure;
plot(energies,fit,'r');
hold on;
plot(energiesAll,data,'o');
hold off

end
%%
T = [8 15 20 25 30 35 40 45 50];
figure;
plot(T,Upperband(xFinal(:,4),xFinal(:,3)),'o-');
%%
yy = MorrSpec(in_con1(1),in_con1(2),in_con1(3),in_con1(4),in_con1(5),energies);
mismatch = [0:sizeE-1];
mismatch = mismatch * in_con1(6)+in_con1(7);
yy = yy + mismatch;
yy = yy/yy(end);
figure; plot(energies,yy);
hold on; plot(energiesAll,data,'r');