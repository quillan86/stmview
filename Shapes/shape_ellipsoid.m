function [x,y,z] = shape_ellipsoid(res,x0,y0,z0,rx,ry,rz)

theta = linspace(0,1*pi,res);
phi = linspace(0,2*pi,res);

[phi,theta] = meshgrid(phi,theta);

x = rx*sin(theta).*cos(phi) + x0;
y = ry*sin(theta).*sin(phi) + y0;
z = rz*cos(theta) + z0;


% figure; 
% surfl(x,y,z); shading flat; colormap(copper)
% freezeColors;
% hold on; 
% surfl(x-2,y-2,z); shading flat; colormap(jet);
% axis equal;
end