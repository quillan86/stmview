
function e_gap=find_pos_gap_edge(G,x,y)

close all
spectrum = squeeze(G.map(x,y,:))';
x
y
% make e run from small to big values
if(G.e(1)>G.e(end))
    e = fliplr(G.e);
    spectrum = fliplr(spectrum);
end
spectrumF = spectrum;
eF = e;
%deal with only positive energies
zero_index = find(e==0);
spectrum = spectrum(zero_index:end);
e = e(zero_index:end);

%smooth spectrum, spectrum is now f
options = fitoptions('Method','SmoothingSpline',...
                     'SmoothingParam',0.9999999);
[f,~,~] = fit(e',spectrum','smoothingspline',options);

%use more points to evaluate the smoothing spline
e1 = linspace(e(1),e(end),300);
% compute the 1st and 2nd derivates of the spectrum
[fx, fxx] = differentiate(f, e1);
N = length(fxx);

% peak find on the first derivative 
sel = (max(fx)-min(fx))/10;
temp = peakfinder(fx,sel);
%test = peakfinder(fx,sel,[],-1);
% find the largest peak in the first peak in the first derivative in energy 
% range [0.05 inf], assumes gap bigger thab 0.05
ind2=find(e1>0.040,1);
ind3=find(e1>0.175,1);
fxpeak = max(fx(temp((temp>=ind2)&(temp<ind3))));

fxpeakglobal = max(fx(temp(temp>=ind2)));
fxpeakglobalG = max(fx(temp));
if(isempty(fxpeakglobal))
    fxpeakglobal = fx(temp(end));

end
if(fxpeakglobal<3)
    fxpeakglobal = fxpeakglobalG;
end
    
    
if(~isempty(fxpeak)&&(fxpeak>(fxpeakglobal/3)))
    relevant_peak = temp(fx(temp)==fxpeak);
else

    relevant_peak = temp(fx(temp)==fxpeakglobal);
    fxpeak = fxpeakglobal;
    if(relevant_peak==300)
        e_gap = e1(300);
        return 
    end
end

    
%truncate the peak vector
temp=temp(find(fx(temp)==fxpeak):end);
%eureka = e1(relevant_peak);
j = relevant_peak+1;
s = j;
k = 0;
while((j<300)&&(fxx(j)<100))%0
    j=j+1;
    k=k+1;
end
%ind = relevant_peak + 1 + k;

if(length(temp)>1)  
    ind = temp(find(temp==relevant_peak)+1);   
else
    ind = j;
end
x1 = ((relevant_peak+1):ind);
temp2 = fx(x1);
last_edge=x1(temp2==min(temp2));

if(length(temp)>2)
    dist1 = -fx(last_edge)+fx(relevant_peak);
    ind3 = temp(find(temp==relevant_peak)+1);
    ind4 = temp(find(temp==relevant_peak)+2);
    x3 = ind3:ind4;
    temp3 = fx(x3);
    last_edge2 = x3(temp3==min(temp3));
    dist2 = -fx(last_edge2)+fx(ind3);
    % if the 2nd jump in the 1st derivative much greater than the 1st jump
    if(dist2>(dist1+0.4))
        relevant_peak = ind3;
        last_edge = last_edge2;
        s = relevant_peak + 1;
    end
end

fxx_min = min(fxx(relevant_peak:last_edge));
e_gap = e1((fxx==fxx_min));
%is there a coherence peak?
x_test = e1(s:last_edge);
y_test = fx(s:last_edge);
z_test = fxx(s:last_edge);
t2 = find(y_test<0,1);
if(~isempty(t2))
    t1 = t2 -1;
    e0 = interp1(y_test([t1 t2]),x_test([t1 t2]),0);

    if(~isnan(e0))
       t=interp1(x_test([t1 t2]),z_test([t1 t2]),e0);
       w = min(1,abs(t/500)); 
       e_gap = (1-w)*e_gap+w*e0;
        
    end
end


%e0=interp1(fx(s:last_edge),e1(s:last_edge),0)

% 

% range1 = e1(relevant_peak);
% range2 = e1(last_edge);
%  figure(25), plot(eF,spectrumF,'-k')
%  %plot(f,'-k') 
%  hold on
%  plot([range1 range1],[min(spectrum) max(spectrum)],'-r',[e_gap e_gap],[min(spectrum) max(spectrum)],'-g',[range2 range2],[min(spectrum) max(spectrum)],'-b');
   %figure(26), plot(e1, fx,'-r',[range1 range1],[min(fx) max(fx)],'-b',[e_gap e_gap],[min(fx) max(fx)],'-g',[range2 range2],[min(fx) max(fx)],'-b');
  %figure(27), plot(e1, fxx,'-r',[range1 range1],[min(fxx) max(fxx)],'-b',[e_gap e_gap],[min(fxx) max(fxx)],'-g',[range2 range2],[min(fxx) max(fxx)],'-b');
end