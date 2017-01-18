function [x,y,z] = drawEllipse(res,origin,rx,ry )
phi = linspace(0,2*pi,res);
x = rx*cos(phi) + origin(1);
y = ry*sin(phi) + origin(2);
z = zeros(size(phi))+ origin(3);
%figure;
%plot3(x,y,z);
%axis equal;
end