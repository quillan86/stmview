function [p,pfit] = cuprate_fano_fit(x,y,gap_index,gap_index_neg)

gap_val_index = gap_index;
if gap_val_index == 0
    gap_val_index = 1;
end
pt1 = max(gap_val_index-25,1);  

gap_val_index  = gap_index_neg;
if gap_val_index == 0
    gap_val_index = 201;
end
pt4 = min(gap_val_index);

%pp = [pt1 85 114 pt4]; % UD20
pp = [pt1 30 114 pt4]; % UD20
%p1 = 1; p2 = 19; p3 = 30; p4 = 38; %70307 UD45

%y = squeeze(squeeze(G.map(r,c,:)));
%x = G.e*1000;
figure; plot(x,y);
[y_new x_new] = piecewise_spectra(y,pp,x);
hold on; plot(x_new,y_new,'r.');
%tic; 
[p, g] = fano_fit3(x_new',y_new); 
%toc;
yp = feval(p,x);
hold on; plot(x,yp,'g');
pfit = pp;
%p
ylim([0 max(y)]);
xlim([x(pt4) x(pt1)]);
end