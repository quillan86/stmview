function pp = fit_1Dgaussians_cuts(cut,init_param,n)
[nr,nc] = size(cut.cut);
p_init = init_param;
for i = 1:nc
    pp(i,:) = fit_1Dgaussians(n,cut,i,p_init);
    p_init = pp(i,:);
end
figure; plot(pp(:,5),cut.e)
end