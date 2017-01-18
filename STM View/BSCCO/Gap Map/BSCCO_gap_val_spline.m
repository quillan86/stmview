function [neg_e, neg_h, pos_e, pos_h] = BSCCO_gap_val_spline(x,y)
diff = abs(x(1)-x(2));
xx = x(1):-diff/10:x(end);

[yy1] = spaps(x,y,1e-4);
%[yy2] = spaps(x,y,7e-8);
val1 = fnval(yy1,xx);
%val2 = fnval(yy2,xx);
%figure; plot(xx,val1); hold on; plot(xx,val2,'rx'); hold on; plot(x,y,'.');

[pks1, locs1]= findpeaks(val1,'SORTSTR','descend');
%[pks2, locs2]= findpeaks(-val1,'SORTSTR','descend');

%  figure; plot(xx,val1);
%   hold on; plot(xx(locs1),pks1, 'k^','markerfacecolor',[0 1 0]);
  

if isempty(locs1)
    neg_e = 0;
    neg_h = 0;
    pos_e = 0;
    pos_h = 0;
    return;    
else
    if xx(locs1(2)) < 0         
        neg_h = val1(locs1(2)); % negative side Ic
        neg_e = xx(locs1(2));    
        pos_h = val1(locs1(1)); % positive side Ic
        pos_e = xx(locs1(1));
    else
        neg_h = val1(locs1(1)); % negative side Ic
        neg_e = xx(locs1(1));    
        pos_h = val1(locs1(2)); % positive side Ic
        pos_e = xx(locs1(2));
    end
end
%  figure; plot(xx,val1,'r.'); hold on; plot(x,y,'.');
%  hold on; plot(xx,val1);
%  hold on; plot(pos_e,pos_h, 'k^','markerfacecolor',[0 1 0]);
%  hold on; plot(neg_e,neg_h, 'k^','markerfacecolor',[1 0 0]);
end