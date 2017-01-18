test = Fano.map(:,:,7);
%%
clear A;
A = (test > 600);
img_plot2(A);
%%
e = G.e*1000;
gap = Delta_d.map;
gap_index = index_val_map(gap,e);
gap_index_neg = index_val_map(-gap,e);
%%
[rr,cc] = find(A ==1);
img_plot2(A);
hold on;
for i = 1:length(rr);
    plot(cc(i),rr(i),'rx'); hold on;
end
%%
i = 3;
r = rr(i);
c = cc(i);
y = squeeze(squeeze(G.map(r,c,:)));
%yfix = linspace(0.66,0.57,12);
%y(44:55) = yfix;
[p,pfit] = cuprate_fano_fit(e,y,gap_index(r,c),gap_index_neg(r,c));
hold on; plot([gap(r,c) gap(r,c)]*1000,get(gca,'ylim'));
p
%%

%%
img_plot2(Fano_rev.map(:,:,7));
caxis([0 10]);
img_plot2(map(:,:,7));
caxis([0 10]);

%%
gap_index(r,c)
%%
yp = feval(p,e);
%figure; plot(e,yp);
figure; plot(e,smooth(y - yp));
%figure; plot(num_der2b(3,smooth(y-yp)));