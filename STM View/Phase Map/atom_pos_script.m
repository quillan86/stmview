%%
phi_shift1 = 0;
phi_shift2 = 0;

s_phase1 = phase_map.s_phase1 + pi/2 + phi_shift1;
s_phase2 = phase_map.s_phase2 + pi/2 + phi_shift2;
p_lattice = sin(s_phase1) + sin(s_phase2);
%%
Cu = T_LF_3_LF_10.Cu_index;
img_r = T_LF_3_LF_10.r;
%%
img_plot2(p_lattice);
hold on; scatter(Cu(:,2),Cu(:,1),'rx')
%%
[nr nc] = size(p_lattice);
ll = size(Cu,1)
Cu2 = zeros(ll,4);
n = 1;
m = 2*n + 1;
f = 5; %interpolation factor (keep it odd)
block = zeros(m,m);
for i =1:ll;
    i    
    block = p_lattice(Cu(i,1)-n:Cu(i,1)+n,Cu(i,2)-n:Cu(i,2)+n);  
    block = pix_dim(block,f*m);
    [c_x c_y] = center_of_mass(block);
    Cu2(i,2) = (c_x - ceil(f*m/2))/f + Cu(i,2);
    Cu2(i,1) = (c_y - ceil(f*m/2))/f + Cu(i,1);
    Cu2(i,3) = interp1(1:nr,img_r,Cu2(i,1));
    Cu2(i,4) = interp1(1:nr,img_r,Cu2(i,2));
end

%%
%img_plot2(p_lattice);
hold on; figure; scatter(Cu2(:,2),Cu2(:,1),'rx'); axis off; axis equal;
%hold on; scatter(Cu(:,2),Cu(:,1),'gx')
figure; scatter(Cu2(:,4),Cu2(:,3),'rx'); axis off; axis equal;
%%
figure; scatter(Cu2(:,2),Cu2(:,1),'rx'); axis off; axis equal; zoom(8);
figure; scatter(Cu(:,2),Cu(:,1),'kx'); axis off; axis equal; zoom(8);

%% reconstruct old atom position
[nr nc] = size(p_lattice);

[X Y] = meshgrid(img_r,img_r);

ux = T_LF_3_LF_10.tx - X;
uy = T_LF_3_LF_10.ty - Y;

img_plot2(ux); img_plot2(uy);
%%

for i = 1:ll
    i
    XI = Cu2(i,4); YI = Cu2(i,3);    
    ux_ref(i) = interp2(X,Y,ux,XI,YI);
    uy_ref(i) = interp2(X,Y,uy,XI,YI);
end
%%
figure; scatter(Cu2(:,2),Cu2(:,1),'rx'); axis off; axis equal; 
figure; scatter(Cu2(:,2)+ux_ref(:),Cu2(:,1)+uy_ref(:),'rx'); axis off; axis equal; 

