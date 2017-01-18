function tri_lattice
x = 1:0.1:100;
y = x;
[X,Y] = meshgrid(x,y);
% generate the model points to map onto
R = 1;
N = 6;
theta_avg = 0;
ang = 360/N;
for i = 1:N
    mdl_pt(N+1-i,1) = R*cosd((i-1)*ang + theta_avg); 
    mdl_pt(N+1-i,2) = R*sind((i-1)*ang + theta_avg);
end
z = 0;
A(1) = 3; A(2) = 3; A(3) = 3;
for i = 1:3
    z = z + A(i)*cos(mdl_pt(i,2)*X + mdl_pt(i,1)*Y); 
end
figure; 
surface(X,Y,z);
shading flat; axis equal
end