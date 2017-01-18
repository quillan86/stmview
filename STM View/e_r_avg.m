function new_data = e_r_avg(data)

r = data.r;
[X Y] = meshgrid(r,r);
theta = atan2(Y,X);
%rho = sqrt(X.^2+Y.^2);
rho = abs(X).^4 + abs(Y).^4;
A = rho >= 0.16^4 & rho<= 0.21^4;
map = data.map;
[nr nc nz] = size(map);
avg_map = zeros(nr,nc);
for i = 9:9
    avg_map = avg_map + map(:,:,i);
end

avg_map = avg_map.*A;
n = 45;
tol = 4/180*pi; % 5 degrees
theta_pt = linspace(0,pi/4,n);
size(theta_pt)
for i = 1:n
    B = theta <=theta_pt(i) & theta > theta_pt(i) - tol;
    %img_plot2(B.*avg_map)
    avg_val(i) = sum(sum((B.*avg_map)))/(sum(sum(A.*B)));
end

figure; plot(theta_pt*180/pi,avg_val);
hold on; plot((theta_pt+pi/4)*180/pi,avg_val(end:-1:1));
%img_plot2(avg_map);
%img_plot2(theta);

new_data = data;
map = zeros(129,129);
% theta = linspace(0,360,129);
% for i = 6:12
%     map = map + data.map(:,:,i);
% end
% for i  = 1:129
%     r(i) = sum(map(i,5:40));
% end
% figure; plot(theta(1:129),r(1:129))
% new_data.map = map;
% new_data.e = 1;
%img_obj_viewer2(new_data)
    
end