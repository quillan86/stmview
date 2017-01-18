I = checkerboard;
J = imrotate(I,30);
fixedPoints = [11 11; 41 71];
movingPoints = [14 44; 70 81];
cpselect(J,I,movingPoints,fixedPoints);
 
t = cp2tform(movingPoints,fixedPoints,'nonreflective similarity');
 
% Recover angle and scale by checking how a unit vector 
% parallel to the x-axis is rotated and stretched. 
u = [0 1]; 
v = [0 0]; 
[x, y] = tformfwd(t, u, v); 
dx = x(2) - x(1); 
dy = y(2) - y(1); 
angle = (180/pi) * atan2(dy, dx) 
scale = 1 / sqrt(dx^2 + dy^2)   
%%
clear hex_pt;
clear gtform;
clear hex_pt2;
clear xm ym;

r = 1;
n = 6;
theta = 20;
ang = 360/n;
%generate n-sided polygon
for i = 1:n
    hex_pt(i,1) = cosd((i-1)*ang + theta);
    hex_pt(i,2) = sind((i-1)*ang + theta);
end

%hex_pt = r*[-cosd(ang) sind(ang); cosd(ang) sind(ang); cosd(0+theta) sind(0+theta); cosd(ang) -sind(ang); -cosd(ang) -sind(ang); -cosd(0+theta) sind(0+theta)];
figure;
scatter(hex_pt(:,1),hex_pt(:,2),'bo');
axis equal; 

xform = [1 0 0; 0 1 0; 0 0 1];
gtform = maketform('projective',xform');
for i = 1:n
    [xm(i), ym(i)] = tformfwd(gtform,hex_pt(i,:));
    hex_pt2(i,1) = xm(i); hex_pt2(i,2) = ym(i);
end
for i = 1:n-1
    sqrt((xm(i+1) - xm(i))^2 + (ym(i+1) - ym(i))^2)
end
hold on; scatter(hex_pt2(:,1),hex_pt2(:,2),'r.')
t = cp2tform(hex_pt2,hex_pt,'affine');
hold on;
for i = 1:n
    [xm(i),ym(i)] = tformfwd(t, hex_pt2(i,:));
    scatter(xm(i),ym(i),'gx'); hold on;    
end
for i = 1:n-1
    sqrt((xm(i+1) - xm(i))^2 + (ym(i+1) - ym(i))^2)
end

%%
general_shear_correct(T_JJ, hex_pt2,0);

%%
N = 6;
theta_pts= mod(atan2d(hex_pt(:,2),hex_pt(:,1)),360);
theta_refN = linspace(theta_pts(1),theta_pts(1)+300,N); % all angles of high symmetry
theta_pts = theta_pts - theta_refN';
%% 

general_shear_correct(T,(sq_pts2),45)
%%
hx_pts2 =[690 199;351 196; 172 509; 334 825; 673 828; 852 515];
%%
%[test,tt] = general_shear_correct(FT,(hx_pts2),0);
[test,tt] = general_shear_correct(T2,(hx_pts3),0);
%%
nd2 = fourier_filter(Tcrop,qq(1:3,:),[5 5 5], 1,'amplitude');
%nd2 = fourier_filter(Tcrop,qq(1:6,:),[7 7 7 7 7 7], 1,'amplitude');
%%
nd1 = fourier_filter(Tcrop,qq(1:6,:),[7 7 7 7 7 7], 1,'real');
%%
