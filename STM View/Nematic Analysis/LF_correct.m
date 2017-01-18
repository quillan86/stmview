function LF_correct(img,img_r,phase)
% Determine the final corrected topo
[X Y] = meshgrid(img_r,img_r);
%Q_matrix = [qax, qay; qbx, qby];
q1 = phase.q1; q2 = phase.q2;
Q = [q1(1,1) q1(2,1); q2(1,1) q2(2,1)];

% apply affine transformation to each pixel coordinate to fix phase errors
Inv_Q = inv(Q); % see Hamidian et al. NJP for details
ux_corr = Inv_Q(1,1).*phase.theta1 + Inv_Q(1,2).*phase.theta2;
uy_corr = Inv_Q(2,1).*phase.theta1 + Inv_Q(2,2).*phase.theta2;

% determine shifts in coordinates from  phase correction
topo_f_x = X + ux_corr;
topo_f_y = Y + uy_corr;

% reinterpolate data on transformed coordinate grid

img_correct = griddata(topo_f_x,topo_f_y,img,X,Y,'linear');
A = isnan(img_correct);
img_correct(A) = 0;
f=fft2(img_correct - mean(mean(img_correct)));
f=fftshift(f);
img_plot2(abs(f));
img_plot2(real(f))
img_plot2(imag(f));
end