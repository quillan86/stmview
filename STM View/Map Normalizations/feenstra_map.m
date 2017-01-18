function new_map = feenstra_map(G,I)

new_map = G;

[rxx,ryy,ee]=ndgrid(G.r,G.r,G.e);

nmap = I.map./ee;
e = round(I.e*100000000)/100000000;
index = find(e == 0);
if ~isempty(index)
    nmap(:,:,index)=nmap(:,:,index+1);
    nmap(:,:,index)= 1;
end
new_map.map=G.map./nmap;
end
%
% ng=g;
% 
% [rxx,ryy,ee]=ndgrid(g.rx,g.ry,g.e);
% 
% nmap=c.map./ee;
% if min(abs(c.e))<0.5
% ind=range2ind(0,c.e);
% nmap(:,:,ind)=nmap(:,:,ind+1);
% end
% 
% ng.map=g.map./nmap;