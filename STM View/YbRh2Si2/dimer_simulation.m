function dimer_map =  dimer_simulation(n,m_dimers)
map = zeros(n,n);
[X Y] = meshgrid(1:n,1:n);
dimer_pos = rand(1,m_dimers,2)*n;
s = [-3, 24];
for i = 1:m_dimers
    map = map + Gaussian2D_v2(X,Y,1,[dimer_pos(1,i,1),dimer_pos(1,i,2)],1);
    map = map + Gaussian2D_v2(X,Y,1,[dimer_pos(1,i,1)+s(1),dimer_pos(1,i,2)+s(2)],1);
end

dimer_map = map;
img_plot2(map);
end