function [x y z] =  Cu_atom(A,res,x0,y0,z0)
phi = linspace(0,pi,res);
theta = linspace(0,2*pi,res);

[phi,theta] = meshgrid(phi,theta);

x = A*sin(phi).*cos(theta).*sin(phi).*sin(phi).*cos(2*theta)-x0;
y = A*sin(phi).*sin(theta).*sin(phi).*sin(phi).*cos(2*theta)-y0;
z = A*cos(phi).*sin(phi).*sin(phi).*cos(2*theta)-z0;





%figure; 
%surfl(x,y,z); shading flat; colormap(copper)
%freezeColors;
%hold on; 
%surfl(x-2,y-2,z); shading flat; colormap(jet);


end