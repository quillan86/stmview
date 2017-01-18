figure; plot(energies,MorrSpec(0.1,1,1,150,0.3,energies));
%%
ef = 1;
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

%%
AA = r.*r -1 ;