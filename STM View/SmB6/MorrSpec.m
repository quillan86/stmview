function y = MorrSpec(rc, rf, ef, v, ratio, energies)

%grid size
N = 10000;
[~,sizeE] = size(energies);

%r is the radius
% Need to calculate the number to match up the size of 1st BZ
% 2.0 is calculated based on the volum of ellipsoid in 1st BZ
r = [1:N]/N*2.0;

%band structure
%Fermi surface is set to r=1. 
Ekc = repmat((r.*r-1)*1600,sizeE,1);
Ekf = zeros(sizeE,N)+ef;

%energy range
%energies = [-range:range];
omega1 = repmat(energies',1,N);

%initialize
Gcc0 = zeros(sizeE,N);
Gff0 = Gcc0;
Gcc  = Gcc0;
Gff  = Gcc0;
Gcf  = Gcc0;

%calculation
Gcc0 = (omega1 + i*rc - Ekc).^-1;
Gff0 = (omega1 + i*rf - Ekf).^-1;

Gcc  = (Gcc0.^-1 - v^2.*Gff0).^-1;
Gff  = (Gff0.^-1 - v^2.*Gcc0).^-1;
Gcf  = Gcc0.*v.*Gff;

Nc = -imag(Gcc).*repmat((r.*r),sizeE,1);
Nf = -imag(Gff).*repmat((r.*r),sizeE,1);
Ncf= -imag(Gcf).*repmat((r.*r),sizeE,1);

y = sum(Nc')+2*ratio*sum(Ncf')+ratio*ratio*sum(Nf');
end