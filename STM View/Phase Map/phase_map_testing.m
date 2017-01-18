load('C:\Analysis Code\MATLAB\STM View\Nematic Analysis\work in progress.mat')

%% find Bragg peaks of obj_61114A03_T
T = obj_61114A03_T;
F = fourier_transform2d(T,'none','amplitude','ft');
img_obj_viewer2(F);
%% 
% Bragg peaks are starting from quadrant 1 -> 2 -> 3 -> 4
% q_px = [x1 x2 x3 x4
%         y1 y2 y3 y4]

%in pixels
q_px = [174 84 84 174; 176 177 82 81];
% in coordinates of Fourier Space
q_crd = [2.2531 -2.2531 -2.2531 2.2531; 2.3532 2.4003 -2.3532 -2.4003];

%check that the Bragg Peaks are in the right place
img_plot2(F.map); hold on;
plot(q_px(1,1),q_px(2,1),'rx'); hold on;
plot(q_px(1,2),q_px(2,2),'rx'); hold on;
plot(q_px(1,3),q_px(2,3),'rx'); hold on;
plot(q_px(1,4),q_px(2,4),'rx');
%%  check lock-in reference functions (this function gets called by function phase map)
ref_fun = lockin_ref_fun(T.map,T.r,q_px);
%% find peaks using iso contours
kx = T.r;
ky = T.r;
q1 = ref_fun.q1;
q2 = ref_fun.q2;
[kX kY] = meshgrid(kx,ky);
kZ = zeros(256,256);
S =  sin(q1(1)*kX + q1(2)*kY) + sin(q2(1)*kX + q2(2)*kY); 
%img_plot2(S);
%img_plot2(img1)
p=patch(isosurface(kX,kY,kZ,S,2)); 
%%

%%
phi_map = phase_map(T.map,T.r,(q_px),3);
%% correct phase slips in the phase map using the dialogue
phi_map_cor = phase_slip_correct_dialogue(phi_map);
%% find atoms using phase
%img_plot2(sin(phi_map_cor.s_phase2+phi_map_cor.theta2))
%img_plot2(sin(phi_map_cor.s_phase2))
tot_phase2 = phi_map_cor.s_phase2;%+phi_map_cor.theta2;
tot_phase1 = phi_map_cor.s_phase1;%+phi_map_cor.theta1;

%%
tol = 0.35;
p_lattice = sin(tot_phase1) + sin(tot_phase2); img_plot2(p_lattice);
p_lattice = sin(tot_phase1 + pi) + sin(tot_phase2); img_plot2(p_lattice);

%%
A = sin(tot_phase1) <=1 & sin(tot_phase1) > 1 - 0.4;
B = sin(tot_phase2) <=1 & sin(tot_phase2) > 1 - 0.4;
img_plot2(sin(tot_phase1));
img_plot2(A); img_plot2(B);
img_plot2(A.*B);
%%
%img_plot2(sin(tot_phase1) + sin(tot_phase2)); 
A = p_lattice2 < 2 & p_lattice2 > 2-0.6;
%img_plot2(A);
%img_plot2(T_cor.map);
img_plot2(p_lattice2); hold on;
for i = 1:size(A,1)
    for j = 1:size(A,2)
        if A(i,j) == 1
            plot(j,i,'rx');
        end
    end
 end
%img_plot2(1*A.*T_cor.map - T_cor.map); colormap(gray);
%%
B = mod(tot_phase1,2*pi) <= pi/2 & mod(tot_phase1,2*pi) > pi/2 - 0.1;
img_plot2(B);
img_plot2(sin(tot_phase1))
%%
LF_correct(T.map,T.r,phi_map_cor);
%%
tic; T_cor = LF_correct_map(phi_map_cor,Tlyr); toc;

%%
%%
%%

[tx ty] = LF_coordinates(1,3,phi_map_cor,T);
TT = LF_correct_map_v2(tx,ty,Tlyr);



%%
tmp1 = cut.cut;
for i = 1:15
    tmp1(:,i) = tmp1(:,i)/max(tmp1(:,i));
end
figure; imagesc(flipud(tmp1'));
colormap(gray);