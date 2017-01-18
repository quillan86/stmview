% 

%% initialize 1,0 linecut fit structure 
[nr,nc] = size(cut.cut);
pp_fit = zeros(nc,10);
pp_init = zeros(nc,10);
pp_window = zeros(nc,2);

YRS_10_fit = QPI_gauss_fit_struct([],[],[],[],[],1,cut);
YRS_10_fit = QPI_gauss_fit_struct(YRS_10_fit,0,pp_init,pp_fit,pp_window);
%%  1,0 direction
[nr,nc] = size(cut.cut);
lyr =1;
n =3;
pt1 =1; pt2 = nr-2;
switch n
    case 1
        p_init = [110  7.260  0.5  3.62123];
    case 2
        p_init = [1000.550  2.15  0.5,   10.59  7  1.35   3.7];
        %p_init = [15.5 0.14 0.05 5.5 0.28 0.12 8];
        % p_init = YRS_10_fit.p_fit(lyr-1,:);
    case 3
        %p_init = [0.390 0.25 0.12  0.2032  0.32  0.30  0.1 0.18 0.1 3.62123]
        p_init = [100.0  2.2  0.15,   100.1 6 0.083    100 9 0.10   3.62123];
        %p_init = YRS_10_fit.p_fit(lyr-1,:);    
end
p_temp = fit_1Dgaussians(n,cut,lyr,p_init,pt1,pt2)

%% 1,0 fit structure fill
YRS_10_fit = QPI_gauss_fit_struct(YRS_10_fit,lyr,p_init,p_temp,[pt1 pt2]);


%% initialize 1,1 linecut fit structure
[nr,nc] = size(cut.cut);
pp_fit = zeros(nc,10);
pp_init = zeros(nc,10);
pp_window = zeros(nc,2);

YRS_11_fit = QPI_gauss_fit_struct([],[],[],[],[],1,cut);
YRS_11_fit = QPI_gauss_fit_struct(YRS_11_fit,0,pp_init,pp_fit,pp_window);

%%  1,1 direction
[nr,nc] = size(cut.cut);
lyr = 17;
n =1;
pt1 =1; pt2 = nr-10;
switch n
    case 1
        p_init = [1000.9160    0.23    0.0926   3.62123];
    case 2
        p_init = [90.410  0.03  0.05,   100.19  0.26  0.05   3.7];
        %p_init = [15.5 0.14 0.05 5.5 0.28 0.12 8];
         %p_init = YRS_11_fit.p_fit(lyr+1,:);
    case 3
        %p_init = [0.390 0.25 0.12  0.2032  0.32  0.30  0.1 0.18 0.1 3.62123]
        p_init = [1.0  0.2  0.05,   0.1 0.31 0.083    .05 0.7 1.0   3.62123];
        %p_init = YRS_11_fit.p_fit(lyr-1,:);    
end
p_temp = fit_1Dgaussians(n,cut,lyr,p_init,pt1,pt2)

%% 1,1 fit structure fill
YRS_11_fit = QPI_gauss_fit_struct(YRS_11_fit,lyr,p_init,p_temp,[pt1 pt2]);


%%
pp_gen = YRS_11_fit.p_fit;
figure; 
plot(abs(pp_gen(:,3)*0.7),cut.e,'bx');
hold on;
plot(abs(pp_gen(:,6)*0.7),cut.e,'rx')
hold on;
%plot(pp_gen(:,8),cut.e,'gx');

xlim([0.03 0.2]);
ylim([cut.e(1) cut.e(end)]);
%%
figure;
for i = 1:46
    if pp_gen(i,2) >= pp_gen(i,5)
        plot(pp_gen(i,2),cut.e(i),'bx');hold on;
        plot(pp_gen(i,5),cut.e(i),'rx');hold on;
    else
        plot(pp_gen(i,2),cut.e(i),'rx'); hold on;
        plot(pp_gen(i,5),cut.e(i),'bx'); hold on;
    end
end
 xlim([0.1 0.42]);

