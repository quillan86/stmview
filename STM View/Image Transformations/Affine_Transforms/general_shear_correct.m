function [new_data,tform] = general_shear_correct(data,pts,axis_dir)

N = size(pts,1); % number of points sets shape

if mod(N,2) ~=0
    display('Number of points must be even');
    new_data = [];
    return;
end
    
if isstruct(data) % check if data is a full data structure
    img = data.map;
    coord = data.r;
    if isfield(data,'coord_type')
        c_t = data.coord_type;
    else
        c_t = [];
    end
else % single data image  
    img = data;
    coord = varargin{1};
    c_t = [];
end
[nr,nc,nz] = size(img);

%if applying transformation to real space data need find k-space
%coordinates since those are the coordinates which define the shearing
if ~isempty(c_t)
    if c_t == 'r'       
        k0 = pi/(abs(data.r(1) - data.r(2)));
        switch mod(nr,2)
            case 0
                k = linspace(0,k0,nc/2+1);
                k = [-1*k(end:-1:1) k(2:end-1)];
            case 1
                k=linspace(-k0,k0,nc);
        end
        coord = k;
    end
end

R = 0; 
% for points not using coord_r;
% for i = 1:N
%     crd_pts(i,1) = (pts(i,1));
%     crd_pts(i,2) = (pts(i,2));
%     R = R + norm(crd_pts(i,:));
% end

for i = 1:N
    crd_pts(i,1) = coord((pts(i,1)));
    crd_pts(i,2) = coord((pts(i,2)));
    R = R + norm(crd_pts(i,:));
end


R = R/N; % average length to a vertex

%determine average angle the BZ is off the main axis
%use 1st point to set axis to generate other high symmetry directions and
%then compare deviation of all other points from those directions
ang = 360/N;
theta_pts = mod(atan2d(crd_pts(:,2),crd_pts(:,1)),360);
theta_refN = linspace(0,360-ang,N); % all angles of high symmetry

theta_pts = theta_pts - theta_refN';

% set the axis of lattice to axis_dir to use average angle of input pts
% axis_dir = -1 is a flag to automatically use average angle of pts
if axis_dir == -1
    theta_avg = mean(theta_pts);  
else
    theta_avg = axis_dir;
end

% generate the model points to map onto

for i = 1:N
    mdl_pt(N+1-i,1) = R*cosd((i-1)*ang + theta_avg); 
    mdl_pt(N+1-i,2) = R*sind((i-1)*ang + theta_avg);
end

figure;
scatter(crd_pts(:,1),crd_pts(:,2),'bo'); hold on;
scatter(mdl_pt(:,1),mdl_pt(:,2),'rx'); hold on;
axis equal;

% mapping between crd_pts and mdl_pts to generate global transformation
t = cp2tform(crd_pts,mdl_pt,'projective');
%t = fitgeotrans(crd_pts,mdl_pt,'projective');
t2 = fliptform(t);
for i = 1:N
    [xm,ym] = tformfwd(t, crd_pts(i,:)); 
    scatter(xm,ym,'go'); hold on; 
end

%if working on real space image nead to adjust for origin
if ~isempty(c_t)
    if c_t == 'r'
        for k = 1:nz
            tmp = squeeze(img(:,:,k));
            img(:,:,k) = flipud(tmp');
        end
        coord = data.r;
    end
end   

transform = imtransform(img, t,'bilinear',... 
                        'UData',[coord(1) coord(end)],...
                        'VData', [coord(1) coord(end)],...
                        'XData',[coord(1) coord(end)],...
                        'YData', [coord(1) coord(end)],...
                        'size', size(img));
                    
                    
transform = imtransform(transform, t2,'bilinear',...
                        'UData',[coord(1) coord(end)],...
                        'VData', [coord(1) coord(end)],...
                        'XData',[coord(1) coord(end)],...
                        'YData', [coord(1) coord(end)],...
                        'size', size(img));
if ~isempty(c_t)
    if c_t == 'r'
        for k = 1:nz
            tmp = squeeze(transform(:,:,k));
            transform(:,:,k) = flipud(tmp)'; 
        end
    end
end   
                           
new_data = data;
new_data.map = transform;
IMG(new_data);
tform = t;
axis equal;