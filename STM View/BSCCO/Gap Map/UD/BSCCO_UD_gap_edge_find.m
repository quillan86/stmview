function [sgap dgap] =  BSCCO_UD_gap_edge_find(spectrum,varargin)
sgap = 0;
dgap = 0;

y = spectrum';
if isempty(varargin)
    x = 1:length(y);
else
    x = varargin{1};
end
%figure; plot(x,y);

%choose only positive side of spectrum
x_pos = x(x >=20);
y_pos = y(x >=20);



%smooth spectrum, spectrum is now f
options = fitoptions('Method','SmoothingSpline',...
                     'SmoothingParam',0.002);
[f,~,~] = fit(x_pos',y_pos','smoothingspline',options);
% use a fine spacing to get smooth spectrum fit
x_refine = linspace(x_pos(1),x_pos(end),length(x_pos)*20);
feval = f(x_refine);
%figure; plot(x_pos,y_pos,'rx');
%hold on; plot(x_refine,feval,'g');

[y_d x_d] = num_der2b(1,feval,x_refine);
[y_dd x_dd] = num_der2b(2,feval,x_refine);
%figure; plot(x_d,y_d);

%find mins and max in dI/dV
[pks_max1 loc_max1] = findpeaks(y_d);
[pks_min1 loc_min1] = findpeaks(-y_d);
default = 0;
if numel(loc_min1) == 0
    default = 1;
%    return;
end
% for i = 1:length(loc_max1)
%     hold on; plot([x_refine(loc_max1(i)) x_refine(loc_max1(i))], get(gca,'ylim'),'r')
% end
% for i = 1:length(loc_min1)
%     hold on; plot([x_refine(loc_min1(i)) x_refine(loc_min1(i))], get(gca,'ylim'),'b')
% end

%find mins and max in d2I/dV2
[pks_max2 loc_max2] = findpeaks(y_dd);
if numel(loc_max2) == 0
    return;
end
%[pks_min2 loc_min2] = findpeaks(-y_dd);

% for i = 1:length(loc_max2)
%     hold on; plot([x_refine(loc_max2(i)) x_refine(loc_max2(i))], get(gca,'ylim'),'g-')
% end
% for i = 1:length(loc_min2)
%     hold on; plot([x_refine(loc_min2(i)) x_refine(loc_min2(i))], get(gca,'ylim'),'k-')
% end
if default ==0
e_max2 = fliplr(x_refine(loc_max2)); % energies of max in d2I/dV2
e_min1 = fliplr(x_refine(loc_min1));% energies of min in dI/dV
pt1 = e_max2(e_max2 > e_min1(1)); pt1 = pt1(1); % find first max of d2I/dV2 after first min of dI/dV
end
% if first minimum is past 80mV then set the limits from 50mV to the first
% minimum
tag = 0;
if default == 1
    pt1 = 50;
    pt2 = 200;
    tag = 1;    
    display('here');
elseif pt1 >= 80
    display('pot');
    pt2 = pt1;
    pt1 = 50;   
    if pt2 - pt1 <=50
        pt2 = x_pos(1);
    end
    tag = 1;
else 
    if length(e_min1) > 1
        pt2 = e_min1(2);
    else
        pt2 = x_pos(1); %if only 1 min then set the right point to the end point
    end
end
%if the end points of fit are too close set use to successive mins in dI/dV
if pt2 - pt1 < 40 && tag == 0
    display('nuts');
    pt1 = pt2;
    if length(e_min1) > 2
        pt2 = e_min1(3);
        if pt2 - pt1 <= 50
            pt2 = x_pos(1);
        end
    else
        pt2 = x_pos(1);
    end
end

if(x_pos(1)>x_pos(end))   
    x_pos = fliplr(x_pos);
    y_pos= fliplr(y_pos);
end

left_index = find(x_pos>=pt1,1);
right_index = find(x_pos>=pt2,1);

er = 0.001*x_pos(left_index:right_index);
spectrumr = y_pos(left_index:right_index);

%figure; plot(er,spectrumr)

options = optimset('MaxIter',2000,'MaxFunEvals',1000,'Display','off');
d = min(spectrum);
% UD
params = lsqnonlin(@dynes_dwave_diff,[0.5 0.1 0.1 d],[0.25 0.03 0.03 -0.1],[2 2 0.3 0.3],options,er,spectrumr); 
params2 = lsqnonlin(@dynes_swave_diff,[0.5 0.1 0.1 d],[0.25 0.03 0.03 -0.1],[2 2 0.3 0.3],options,er,spectrumr);

sgap = params2(3);
dgap = params(3);
fit_dwave = dynes_dwave2(params,er);
fit_swave = dynes_swave(params2,er);
figure, plot(x/1000,y,'-k',er,fit_dwave,'-r',er,fit_swave,'-g',[sgap sgap],[min(spectrum) max(spectrum)],'-g',[dgap dgap],[min(spectrum) max(spectrum)],'-r');
title(['left index: ' num2str(x_pos(left_index)) ' - right index: ' num2str(x_pos(right_index))]);

axis([-0.2 0.25 0 max(spectrum)]);


end