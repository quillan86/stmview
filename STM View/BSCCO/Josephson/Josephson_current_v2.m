function [Ic, Vc] = Josephson_current_v2(x,y)

diff = abs(x(1)-x(2));
xx = x(1):-diff/10:x(end);

[yy1] = spaps(x,y,5e-8);
[yy2] = spaps(x,y,1e-8);
val1 = fnval(yy1,xx);
val2 = fnval(yy2,xx);
%figure; plot(xx,val1); hold on; plot(xx,val2,'rx'); hold on; plot(x,y,'.');

[pks1, locs1]= findpeaks(val1-val2,'MINPEAKHEIGHT',0.0004,'MINPEAKDISTANCE',70);
[pks2, locs2]= findpeaks(val2-val1,'MINPEAKHEIGHT',0.0004,'MINPEAKDISTANCE',70);

% figure; plot(xx,val1-val2);
% hold on; plot(xx(locs1),pks1, 'k^','markerfacecolor',[0 1 0]);
% hold on; plot(xx(locs2),-pks2, 'k^','markerfacecolor',[1 0 0]);

if isempty(locs1) || isempty(locs2)
    Ic(1) = 0;
    Ic(2) = 0;
    Vc(1) = 0;
    Vc(2) = 0;
    return;    
end
if length(locs1) > 2 || length(locs2) > 2
    Ic(1) = 0;
    Ic(2) = 0;
    Vc(1) = 0;
    Vc(2) = 0;
    return;
else
    Ic(2) = val2(locs1(end)); % negative side Ic
    Vc(2) = xx(locs1(end));
    
    Ic(1) = val2(locs2(1)); % negative side Ic
    Vc(1) = xx(locs2(1));
end
% figure; plot(xx,val2,'rx'); hold on; plot(x,y,'.');
% hold on; plot(xx,val1);
% hold on; plot(Vc(1),Ic(1), 'k^','markerfacecolor',[0 1 0]);
% hold on; plot(Vc(2),Ic(2), 'k^','markerfacecolor',[1 0 0]);
end