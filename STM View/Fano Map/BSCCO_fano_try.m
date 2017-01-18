%%
Fano_rev = Fano;
spct_map = G.map;
tic;
parfor i = 1:length(rr)
r = rr(i);
c = cc(i);
y = squeeze(squeeze(spct_map(r,c,:)));
[p,pfit] = cuprate_fano_fit(e,y,gap_index(r,c),gap_index_neg(r,c));
map_a(i) = p.a;
map_b(i) = p.b;
map_c(i) = p.c;
map_d(i) = p.d;
map_e(i) = p.e;
map_g(i) = p.g;
map_q(i) = p.q;
end
toc;
for i = 1:length(rr);
    Fano_rev.map(rr(i),cc(i),1) = map_a(i);
    Fano_rev.map(rr(i),cc(i),2) = map_b(i);
    Fano_rev.map(rr(i),cc(i),3) = map_c(i);
    Fano_rev.map(rr(i),cc(i),4) = map_d(i);
    Fano_rev.map(rr(i),cc(i),5) = map_e(i);
    Fano_rev.map(rr(i),cc(i),6) = map_g(i);
    Fano_rev.map(rr(i),cc(i),7) = map_q(i);
end