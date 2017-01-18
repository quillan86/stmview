function FitMorrSpect(e,didv)
x = e;
y = didv/didv(end);
ind = [1:50 140:201];
x1 = x(ind);
y1 = y(ind);

p = polyfit(x1',y1,2);
f1 = polyval(p,x);

%figure; plot(x1,y1,'o');
%hold on; plot(x,y,'r');
%hold on; plot(x,y-f1','g');

y2 = y - f1';

ind2 = 50:140;
x2 = x(ind2);
y2 = y2(ind2);
%hold on; plot(x2,y2,'k');
g = [1,10,-3.5,25,-0.023,-4];

fit = MorrSpec(g(1),g(2),g(3),g(4),g(5),x2);
%figure; plot(x2,fit);
%hold on; plot(x2,y2,'k');

s = optimset('MaxFunEvals',3000,'MaxIter',3000,'TolFun',1e-5);
param = fminunc(@morr_resid,g,s);
param

figure; plot(x2,MorrSpec(param(1),param(2),param(3),param(4),param(5),x2)+param(6));
hold on; plot(x2,y2,'rx');

    function resi = morr_resid(p)
        ff = MorrSpec(p(1),p(2),p(3),p(4),p(5),x2);
        ff = ff + p(6);
        er = y2 - ff';
        resi = log(er'*er);        
    end

end