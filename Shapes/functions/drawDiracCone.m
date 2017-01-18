function [x,y,z] = drawDiracCone(res,origin,rx,ry)
z = linspace(-1,1,res);
phi = linspace(0,2*pi,res);

[phi,z] = meshgrid(phi,z);

x = rx*z*cos(phi) + origin(1);
y = ry*z*sin(phi) + origin(2);
z = z + origin(3);

hold on;
surfl(x,y,z);shading flat; 
end