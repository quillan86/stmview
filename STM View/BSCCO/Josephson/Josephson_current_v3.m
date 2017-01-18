function [Ic, Vc] = Josephson_current_v3(x,y)

diff = abs(x(1)-x(2));
xx = x(1):-diff/10:x(end);

[yy1] = spaps(x,y,1e-8);
%[yy2] = spaps(x,y,7e-8);
val1 = fnval(yy1,xx);
%val2 = fnval(yy2,xx);
%figure; plot(xx,val1); hold on; plot(xx,val2,'rx'); hold on; plot(x,y,'.');

[pks1, locs1]= findpeaks(val1,'SORTSTR','descend');
[pks2, locs2]= findpeaks(-val1,'SORTSTR','descend');

 %figure; plot(xx,val1);
 % hold on; plot(xx(locs1),pks1, 'k^','markerfacecolor',[0 1 0]);
 % hold on; plot(xx(locs2),-pks2, 'k^','markerfacecolor',[1 0 0]);

if isempty(locs1) || isempty(locs2)
    Ic(1) = 0;
    Ic(2) = 0;
    Vc(1) = 0;
    Vc(2) = 0;
    return;    
else
    Ic(2) = val1(locs2(1)); % negative side Ic
    Vc(2) = xx(locs2(1));
    
    Ic(1) = val1(locs1(1)); % negative side Ic
    Vc(1) = xx(locs1(1));
end
 %figure; plot(xx,val1,'r.'); hold on; plot(x,y,'.');
 %hold on; plot(xx,val1);
 %hold on; plot(Vc(1),Ic(1), 'k^','markerfacecolor',[0 1 0]);
 %hold on; plot(Vc(2),Ic(2), 'k^','markerfacecolor',[1 0 0]);
end