function r = k_to_r_coord(k)
k0 = (abs(k(1))+abs(k(end)))/2;
dr = pi/k0;
r = linspace(0,dr*(length(k)-1),length(k));
end