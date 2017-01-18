function rounded_square(xx,yy)
%x = -1.5:0.01:1.5;
% x = ones(1,length(theta));
% x = cos(theta);
% y = sqrt(1 + (tan(theta)).^2);
% figure; plot(x,y);
%b = 0.5;
%figure;
% for i = 0.1:0.1:1
% y = (1/b)*acos(i./(cos(b*x)));
%  hold on; plot(x,y);
% end
% 
% axis equal;
% [X Y] = meshgrid(x,x);
%  B = 1;
%  %Z = B*cos(imrotate(X,45,'bicubic','crop')) + B*sin(imrotate(Y,45,'bicubic','crop'));
%  Z = B*cos(0.5*X).*cos(0.5*Y); 
%  figure; contour(Z);
%axis equal;
for i = 1:length(xx)
    theta(i) = atan(yy(i)/xx(i));
    q(i) = sqrt(xx(i)^2 + yy(i)^2);
end
figure; plot(theta,q);
theta
%theta = 0:0.01:pi/2;
%q = 1 + cos(theta);
%q = ones(1,length(theta));
%q = q*5;
%q = cos(theta);
%figure; plot(theta,q);
%figure; polar(theta,q);
%[X Y] = pol2cart(theta,q);
%figure; plot(X,Y);
%axis equal
[A Y2] = legendrefit(q,3);
A
figure; plot(theta, Y2,'r')
size(theta)
size(Y2)
figure; polar(theta,Y2')
end
