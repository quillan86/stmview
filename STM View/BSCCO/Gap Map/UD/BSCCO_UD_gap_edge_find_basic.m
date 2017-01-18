function [sgap dgap] =  BSCCO_UD_gap_edge_find_basic(low_bnd,up_bnd,spectrum,varargin)
sgap = 0;
dgap = 0;

y = spectrum';
if sum(y) == 0
    sgap = 0;
    dgap = 0;
    return;
end
if isempty(varargin)
    x = 1:length(y);
else
    x = varargin{1};
end
%figure; plot(x,y);

if(x(1)>x(end))   
    x = fliplr(x);
    y= fliplr(y);
end

%UD20
%left_index = find(x>=90,1);
%right_index = find(x>=200,1);

%UD45
left_index = find(x>=low_bnd,1);
right_index = find(x>=up_bnd,1);

er = 0.001*x(left_index:right_index);
spectrumr = y(left_index:right_index);

%figure; plot(er,spectrumr)

options = optimset('MaxIter',2000,'MaxFunEvals',1000,'Display','off');
d = min(spectrum);
% UD20 - 70809240
%params = lsqnonlin(@dynes_dwave_diff,[0.5 0.1 0.1 d],[0.25 0.03 0.03 -0.1],[2 2 0.3 0.3],options,er,spectrumr); 
%params2 = lsqnonlin(@dynes_swave_diff,[0.5 0.1 0.1 d],[0.25 0.03 0.03 -0.1],[2 2 0.3 0.3],options,er,spectrumr);

% UD45 - 70703A04
params = lsqnonlin(@dynes_dwave_diff,[0.5 0.1 0.1 d],[0.25 0.03 0.03 -0.1],[2 2 0.3 0.3],options,er,spectrumr); 
params2 = lsqnonlin(@dynes_swave_diff,[0.5 0.1 0.1 d],[0.25 0.03 0.03 -0.1],[2 2 0.3 0.3],options,er,spectrumr);



sgap = params2(3);
dgap = params(3);
% fit_dwave = dynes_dwave2(params,er);
% fit_swave = dynes_swave(params2,er);
% figure, plot(x/1000,y,'-k',er,fit_dwave,'-r',er,fit_swave,'-g',[sgap sgap],[min(spectrum) max(spectrum)],'-g',[dgap dgap],[min(spectrum) max(spectrum)],'-r');
% title(['left index: ' num2str(x(left_index)) ' - right index: ' num2str(x(right_index)) ' gapval_d = ' num2str(dgap)]);
% 
% axis([-0.0 0.35 0 max(spectrum(1:length(spectrum)/2))]);


end