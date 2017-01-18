function e_gap=find_neg_gap_edge(G,x,y)

%close all
spectrum = squeeze(G.map(x,y,:))';
x
y
% make e run from small to big values
if(G.e(1)>G.e(end))
    e = fliplr(G.e);
    spectrum = fliplr(spectrum);
else
    e = G.e;
end
e = e*1000;
%smooth spectrum, spectrum is now f
options = fitoptions('Method','SmoothingSpline',...
                     'SmoothingParam',0.4);
[f,~,~] = fit(e',spectrum','smoothingspline',options);
f = f(e);

sel = (max(f)-min(f))/2;
temp = peakfinder(f,sel);
e_gap=e(temp(end));
figure; plot(e,spectrum);
end