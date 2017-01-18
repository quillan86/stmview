function gap = find_pos_gap(G)
tic
map = G.map;
mapdim = size(map);
N = mapdim(1);
gap = zeros(N,N);
for i=1:N
    for j=1:N
        gap(i,j)=find_pos_gap_edge(G,i,j);
    end

end
toc
end

