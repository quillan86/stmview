function [sgap, dgap] = find_gap_edge_dynes(G,r,c)

%x
%y
spectrum = squeeze(G.map(r,c,:))';

if(G.e(1)>G.e(end))
    e = fliplr(G.e);
    spectrum = fliplr(spectrum);
else
    e = G.e;
end
%figure(9), plot(e,spectrum,'-k');


% UD 45
 left_index = find(e>0.033,1);
 right_index = find(e>0.15,1);
 
 %UD20
 %left_index = find(e>=0.05,1)
 %right_index = find(e>=0.2,1)

% OD
%left_index = find(e>-0.040,1); %55mv
%right_index = find(e>-0.015,1);

er = e(left_index:right_index);
spectrumr = spectrum(left_index:right_index);

% zero_index = find(e==0);
% e = e(zero_index:end);
% spectrum = spectrum(zero_index:end);




%options = optimoptions(@lsqnonlin,'MaxIter',2000,'MaxFunEvals',1000,'Display','off');
options = optimset('MaxIter',2000,'MaxFunEvals',2000,'Display','off');
d = min(spectrum);

% UD
params = lsqnonlin(@dynes_dwave_diff,[0.5 0.1 0.1 d],[0.25 0.03 0.03 -0.1],[2 2 0.3 0.3],options,er,spectrumr); 
params2 = lsqnonlin(@dynes_swave_diff,[0.5 0.1 0.1 d],[0.25 0.03 0.03 -0.1],[2 2 0.3 0.3],options,er,spectrumr);

%OD
%params  = lsqnonlin(@dynes_dwave_diff,[2 0.05 0.03 d],[0.25 0.03 0.01 -0.1],[4 2 0.05 0.3],options,er,spectrumr); %OD
%params2= lsqnonlin(@dynes_swave_diff,[2 0.1 0.03 d],[0.25 0.03 0.01 -0.1],[4 2 0.05 0.3],options,er,spectrumr); %OD

sgap = params2(3);
dgap = params(3);
fit_dwave = dynes_dwave2(params,er);
fit_swave = dynes_swave(params2,er);
figure, plot(e,spectrum,'-k',er,fit_dwave,'-r',er,fit_swave,'-g',[sgap sgap],[min(spectrum) max(spectrum)],'-g',[dgap dgap],[min(spectrum) max(spectrum)],'-r');
title(['left index: ' num2str(e(left_index)) ' - right index: ' num2str(e(right_index)) ' (x,y) = (' num2str(c) ',' num2str(r) ')']);
%figure(10), plot(e,spectrum,'-k',e,fit,'-r',[dgap dgap],[min(spectrum) max(spectrum)],'-r');

axis([-0.15 0.20 0 max(spectrum)]);