function QPI_sim_2D(nr,nc,res)

k_E = 1.5*(1:res:10).^0.5;
pos = [5 5; 6.5 6.5; 2 11; 9 1.75; 15 6; 18 13; 10 17];
%pos = [5 5];
x = 0:0.02:nr;
y = 0:0.02:nc;

[X,Y] = meshgrid(x,y);
i = 1;
Z = zeros(length(y),length(x),length(k_E));
%E = 4;
for E = 1:length(k_E)
    tmp = 0;
    for i = 1:size(pos,1)
        tmp = tmp + cos(2*pi*k_E(E)*sqrt((X-pos(i,1)).^2 + (Y-pos(i,2)).^2)).*Lorentzian2D(x,y,[1 pos(i,1) pos(i,2) 0.7 0.7 0 0 0 0]);        
       %tmp = tmp + cos(2*pi*k_E(E)*sqrt((X-pos(i,1)).^2 + (Y-pos(i,2)).^2)).*Gaussian2D(x,y,1.5,1.5,0,[pos(i,1) pos(i,2)],1);        
    end
    Z(:,:,E) = tmp;
end

G = make_struct;
G.map = Z;
G.e = 1:length(k_E);
G.var = '_sim';
G.coord_type = 'r';
G.name = 'QPI';
G.r = x;
G.type = 0;
G.ave = avg_map(Z);
IMG(G);
end