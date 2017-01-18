function P=findpeaks_3(x,y,SlopeThreshold,AmpThreshold,smoothwidth,peakgroup)
% Function to locate the positive peaks in a noisy x-y data
% set.  Detects peaks by looking for downward zero-crossings
% in the first derivative that exceed SlopeThreshold.
% Returns list (P) containing peak number and
% position, height, and width of each peak. SlopeThreshold,
% AmpThreshold, and smoothwidth control sensitivity
% Higher values will neglect smaller features. Peakgroup
% is the number of points around the "top part" of the peak.
smoothwidth=round(smoothwidth);
peakgroup=round(peakgroup);
d=fastsmooth(deriv(y),smoothwidth);
%d=-fastsmooth(deriv(d1),smoothwidth);
%d=fastsmooth(deriv(d2),smoothwidth);
n=round(peakgroup/2+1);
P=[0 0 0];
vectorlength=length(y);
peak=1;
AmpTest=AmpThreshold;
for j=smoothwidth:length(y)-smoothwidth,
   if sign(d(j)) > sign (d(j+1)), % Detects zero-crossing
     if d(j)-d(j+1) > SlopeThreshold*y(j), % if slope of derivative is larger than SlopeThreshold
        if y(j) > AmpTest,  % if height of peak is larger than AmpThreshold
          for k=1:peakgroup, % Create sub-group of points near peak
              groupindex=j+k-n + 1;
              if groupindex<1, 
                  groupindex=1;
              end
              if groupindex>vectorlength, 
                  groupindex=vectorlength;
              end
            %xx(k)=x(groupindex+1);
            %yy(k)=y(groupindex+1);
            xx(k)=x(min(groupindex+1,length(x)));
            yy(k)=y(min(groupindex+1,length(x)));
          end
          
         % figure; plot(x,y,'rx'); hold on; plot([x(j+1) x(j+1)], get(gca,'ylim'),'k'); hold on; plot(xx,yy);
          
          %[coef]=polyfit(xx,(yy),2);  % Fit parabola to log10 of sub-group         
          [coef]=polyfitn(xx,yy,'constant x x^2 x^4');
          diffr = mean(diff(xx));          
          x_fine = xx(1):diffr/50:xx(end);           
          %f = polyval(coef,x_fine);
          f = polyvaln(coef,x_fine);
         % h = figure; plot(xx,yy,'b'); hold on; plot(x_fine,f,'r');pause; close(h);
          PeakX = mean(x_fine(f == max(f))); % Compute peak position and height of fitted parabola
          PeakY = max(max(f));       
          
         %figure; plot(x,y,'bx');
         %hold on; plot(x_fine,f,'g'); hold on; plot([PeakX PeakX],get(gca,'ylim'));
          
          
          % Construct matrix P. One row for each peak 
          % detected, containing the peak number, peak 
          % position (x-value) and peak height (y-value).
          P(peak,:) = [round(peak) PeakX PeakY];
          peak=peak+1;
        end
      end
   end
end