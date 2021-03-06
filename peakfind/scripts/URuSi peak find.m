x = G.e(end:-1:1)*1000; 
y = squeeze(squeeze(G.map(1,50,end:-1:1)));
y = squeeze(squeeze(G.ave(end:-1:1)));
%%
P2 = findpeaks(x,y,0.022,0.028,1,6);
%(x,y,0.01,19,2,4); %
P2pos = P2(:,2);
figure; plot(x,y)
%%
[nr nc nz] = size(G.map);
%nr = 10;
%nc = 10;
P1 = nan(nr,nc);
P2 = nan(nr,nc);
pk_er = 3; 
x = G.e(end:-1:1)*1000; 
p1 = -6; p2 = 3;
for i = 1:nr
    for j = 1:nc       
        y = squeeze(squeeze(squeeze(G.map(i,j,end:-1:1))));
        P = findpeaks(x,y,0.009,0.158,1,6);
        Ppos = P(:,2);
        [r1 c1] = find(Ppos > p1 - pk_er & Ppos < p1 + pk_er);
        [r2 c2] = find(Ppos > p2 - pk_er & Ppos < p2 + pk_er);
        if ~isempty(r1)            
            P1(i,j) = Ppos(r1(end),c1(end));            
        end
        
        if ~isempty(r2)
            P2(i,j) = Ppos(r2(end),c2(end));
        end
        %clear r1 r2 c1 c2;
    end
end
figure; pcolor(P1); shading flat;
figure; pcolor(P2); shading flat;