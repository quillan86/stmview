function [x y z] = Ox_atom(A,res,x0,y0,z0)

phi = linspace(0,pi,res);
theta = linspace(0,2*pi,res);

[phi,theta] = meshgrid(phi,theta);

x = A*sin(phi).*cos(theta).*sin(phi).*cos(theta).*sin(phi).*cos(theta)-x0;       
y = A*sin(phi).*sin(theta).*sin(phi).*cos(theta).*sin(phi).*cos(theta)-y0;       
z = A*cos(phi).*            sin(phi).*cos(theta).*sin(phi).*cos(theta)-z0;
      

% figure; 
%surfl(x,y,z); shading interp; colormap(copper); axis equal


end