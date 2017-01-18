function bt = URuSi_bottom_ind(x,y,ind1,ind2,varargin)
if nargin <=4
    ysm = y;
else 
    w = (varargin{1});
    ysm = boxcar_avg(y,w);  
end

if isempty(ysm) 
    bt = [];
    return;
end

ysm = ysm(ind1:ind2); xsm = x(ind1:ind2);
%ysm = max(ysm) - ysm;
%[pks loc] = findpeaks(ysm);
%tmp = xsm(loc);
tmp = xsm(ysm == min(ysm)); 
bt = tmp(1);
if sum(sum(xsm(1:5) == bt)) > 0
    ysm = max(ysm) - ysm;
    [pks loc] = findpeaks(ysm);
    tmp = xsm(loc);
    if ~isempty(tmp) 
        tmp = tmp(1);
        bt = tmp;
    end
end

%figure;plot(x,y); hold on; plot(xsm,ysm,'r'); hold on; plot([tmp tmp],get(gca,'ylim'));

end