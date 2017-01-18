function new_data = LF_correct_map(phase,data,varargin)

if isstruct(data)
    map = data.map;    
    img_r = data.r;    
else
    map = data;
    img_r = varargin{1}; %if the input is not a structure, then the user also input the coordinate of the image
end
[nr nc nz] = size(map);
new_map = zeros(nr,nc,nz);
[X Y] = meshgrid(img_r,img_r);

%Q_matrix = [qax, qay; qbx, qby];
q1 = phase.q1; q2 = phase.q2;
Q = [q1(1,1) q1(2,1); q2(1,1) q2(2,1)];

% apply affine transformation to each pixel coordinate to fix phase errors
Inv_Q = inv(Q); % see Hamidian et al. NJP (2011) for details
ux_corr = Inv_Q(1,1).*phase.theta1 + Inv_Q(1,2).*phase.theta2;
uy_corr = Inv_Q(2,1).*phase.theta1 + Inv_Q(2,2).*phase.theta2;

% determine shifts in coordinates from  phase correction
topo_f_x = X + ux_corr;
topo_f_y = Y + uy_corr;

% reinterpolate data on transformed coordinate grid
for k = 1:nz
    img_correct = [];
    tic; img_correct = griddata(topo_f_x,topo_f_y,map(:,:,k),X,Y,'linear'); toc;
    A = isnan(img_correct);
    img_correct(A) = 0;
    new_map(:,:,k) = img_correct;    
end
if isstruct(data)
    new_data = data;
    new_data.map = new_map;
    new_data.var = [new_data.var '_LFCorrect'];
    new_data.ops{end+1} = 'LF Correction';
else
    new_data = new_map;
end
% f=fft2(img_correct - mean(mean(img_correct)));
% f=fftshift(f);
% img_plot2(abs(f));
% img_plot2(real(f))
% img_plot2(imag(f));
end