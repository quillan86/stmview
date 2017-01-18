function [dgap,sgap] = find_pos_gap_dynes(G)
tic
map = G.map;
mapdim = size(map);
N = mapdim(1);
dgap = zeros(N,N);
sgap = dgap;
for i=1:N
    for j=1:N
        [sgap(i,j), dgap(i,j)]=find_gap_edge_dynes(G,i,j);
    end

end
toc
end