function [x y z] = sphere_atom(A,res,x0,y0,z0)

phi = linspace(0,pi,res);
theta = linspace(0,2*pi,res);

[phi,theta] = meshgrid(phi,theta);

x = A*sin(phi).*cos(theta)-x0;       
y = A*sin(phi).*sin(theta)-y0;       
z = A*cos(phi)-z0;
      

% figure; 
%surfl(x,y,z); shading interp; colormap(copper); axis equal


end