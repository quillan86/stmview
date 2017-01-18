function y = Residual(x)
%RESIDUAL Calculate the log residual based on the 1D model
%   x is a vector of variables defined as follows 
%   x(0) x(1) x(2) x(3) x(4)   x(5)      x(6)              x(7)
%   rc,  rf,  ef,  v,   ratio, energies, background slope, intercept
%
% One would need to set the data and energies to be fitted to be global 
% under the name of dataOrigin and energies.

%   Yang He
%   

%fitted spectra
% used global data here to avoid loading data repeatedly when calling 
% function Residual
global dataOrigin;
global colum;
global energies
data = dataOrigin(:,colum);
[sized,~] = size(data);

%energies = [-100:100];
[~,sizeE] = size(energies);

data = data([sized-sizeE+1:sized]);
data = data/data(sizeE);

fit = MorrSpec(1,x(2),x(3),x(4),x(5),energies);
fit = fit/fit(sizeE);

mismatch = [0:sizeE-1];
mismatch = mismatch * x(6)+x(7);
fit = fit + mismatch;
err = fit' - data;

y = log(err'*err);
end
%  function y = MorrSpec(rc, rf, ef, v, ratio, energies)
% 
% %grid size
% N = 10000;
% [~,sizeE] = size(energies);
% 
% %r is the radius
% % Need to calculate the number to match up the size of 1st BZ
% % 2.0 is calculated based on the volum of ellipsoid in 1st BZ
% r = [1:N]/N*2.0;
% 
% %band structure
% %Fermi surface is set to r=1. 
% Ekc = repmat((r.*r-1)*1600,sizeE,1);
% Ekf = zeros(sizeE,N)+ef;
% 
% %energy range
% %energies = [-range:range];
% omega1 = repmat(energies',1,N);
% 
% %initialize
% Gcc0 = zeros(sizeE,N);
% Gff0 = Gcc0;
% Gcc  = Gcc0;
% Gff  = Gcc0;
% Gcf  = Gcc0;
% 
% %calculation
% Gcc0 = (omega1 + i*rc - Ekc).^-1;
% Gff0 = (omega1 + i*rf - Ekf).^-1;
% 
% Gcc  = (Gcc0.^-1 - v^2.*Gff0).^-1;
% Gff  = (Gff0.^-1 - v^2.*Gcc0).^-1;
% Gcf  = Gcc0.*v.*Gff;
% 
% Nc = -imag(Gcc).*repmat((r.*r),sizeE,1);
% Nf = -imag(Gff).*repmat((r.*r),sizeE,1);
% Ncf= -imag(Gcf).*repmat((r.*r),sizeE,1);
% 
% y = sum(Nc')+ratio*sum(Ncf')+ratio*ratio*sum(Nf');





