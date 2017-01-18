%%%%%%%
% CODE DESCRIPTION: 
%   
% INPUT: spectrum - dI/dV curve
%        energy - bias energy of curve
%        sm - degree of smoothening in smoothspline from 1 (no smoothing)
%        to 0
%        varargin - contains option parameters
%                   - dbl_pk_optn (if there are double peaks set gap to
%                   zero
%                   - dbl_pk_percent (double peaks are counted only when
%                     the height of one is a certain percentage of the
%                     highest one)
%                   - pk_rng_optn (if no peak is detected set the gap to
%                     the energy at which spectrum attains its maximum
%                     value
%                   - others to be added
%
% OUTPUT: e_gap - the final determined gap edge
%         varargout - contains additional information
%                      - dbl_pk_check (was there a double detected)
%                      - no_pk_check (no peak detected)
%
% CODE HISTORY
%
% 131208 MH  Created
%%%%%%%

function [e_gap pk_mag varargout] = BSCCO_OD_gap(spectrum,energy,sm,varargin)
 
x = energy;
y = spectrum;

if ~isempty(varargin)
    dbl_pk_optn = varargin{1};
    dbl_pk_frac = varargin{2};
    pk_rng_optn = varargin{3};
end

% make energy run from small to big values
if(x(1)>x(end))
    x = fliplr(x);
    y = fliplr(y);
end

%smooth spectrum, spectrum is now f
options = fitoptions('Method','SmoothingSpline',...
                     'SmoothingParam',sm);
[f,~,~] = fit(x',y,'smoothingspline',options);
x_refine = linspace(x(1),x(end),length(x)*20);
feval = f(x_refine);


%[y1 x1] = num_der2b(1,feval,x_refine);
peaks = 0;
sel = (max(feval)-min(feval))/160;
[peaks_loc peaks_mag] = peakfinder(feval,sel);
if isempty(peaks_loc)
    e_gap = 0;
    pk_mag = 0;
    dbl_pk_check = 0;
    no_pk_check = 1;
    varargout{1} = dbl_pk_check;
    varargout{2} = no_pk_check;
    return;
end
% peak with highest magnitude and furthest from 0V is the e_gap 
e_gap =  x_refine(max(peaks_loc(peaks_mag == max(peaks_mag))));
pk_mag = max(peaks_mag);

% if no peak is found, then this option sets the gap value to value
% at which the spectrum attains its maximum value
no_pk_check = 0;
if pk_rng_optn
    if peaks_loc(1,1) == 0 %no peak found
        e_gap = max(x_refine(feval == max(feval)));
        pk_mag = max(feval);
        no_pk_check = 1;
    end
end

%if the max height peaks is within 10% of the next highest peak,
%then set the gap value to 0, the error value.
dbl_pk_check = 0;
if  dbl_pk_optn
    if (size(peaks_mag,1) > 1)
        sort_peaks = sort(peaks_mag,'descend');
        if (((sort_peaks(1) - sort_peaks(2))/sort_peaks(1)) < dbl_pk_frac)
            e_gap = 0;
            pk_mag = 0;
            dbl_pk_check = 1;
        end
    end
end
varargout{1} = dbl_pk_check;      
varargout{2} = no_pk_check;      


%figure; plot(x_refine,feval); hold on; plot(x,y,'rx');
%hold on; plot([e_gap e_gap], get(gca,'ylim'));
%figure; plot(x1,y1,'g');
%hold on; plot([e_gap e_gap], get(gca,'ylim'));
end