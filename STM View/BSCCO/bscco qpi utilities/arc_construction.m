function [ kxbar, kybar ] = arc_construction( energies,q1,q2,q3,q4,q5,q6,q7, bragg )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

a=sqrt(2)/2;

q1=q1./bragg;
q2=q2./bragg;
q3=q3./bragg;
q4=q4./bragg;
q5=q5./bragg;
q6=q6./bragg;
q7=q7./bragg;



q6y=a.*q6(:,1)-a.*q6(:,2);
q6x=a.*q6(:,2)+a.*q6(:,1);

q4x=a.*q4(:,1)-a.*q4(:,2);
q4y=a.*q4(:,2)+a.*q4(:,1);


q2x=a.*q2(:,1)-a.*q2(:,2);
q2y=a.*q2(:,2)+a.*q2(:,1);


kx=NaN(length(q1),6);
ky=NaN(length(q1),6);
% 
kx(:,1)=q1;
kx(:,2)=q2x+q2y;
kx(:,3)=q6x-q6y;
kx(:,4)=(q3-q7)./(sqrt(2));
kx(:,5)=q5-sqrt(2).*q7;
kx(:,6)=q4x;

ky(:,1)=q5;
ky(:,2)=-q2x+q2y;
ky(:,3)=q6x+q6y;
ky(:,4)=(q3+q7)./(sqrt(2));
ky(:,5)=q1+sqrt(2).*q7;
ky(:,6)=q4y;

n_nans_x=sum(isnan(kx),2);
n_nans_y=sum(isnan(ky),2);


kxbar=squeeze(nanmean(kx,2));
kybar=squeeze(nanmean(ky,2));
kxstdev=squeeze(nanstd(kx,1,2));
kystdev=squeeze(nanstd(ky,1,2));

b=(1-kxbar) ./ (1-kybar);

theta=atan((1-kxbar) ./ (1-kybar))-repmat(pi/4,size(kybar));
kx_up=kxbar+kxstdev;
ky_up=kybar+kystdev;
kx_down=kxbar-kxstdev;
ky_down=kybar-kystdev;
theta_up=atan((1-kx_down) ./ (1-ky_up))-repmat(pi/4,size(kybar))-theta;
theta_down=atan((1-kx_up) ./ (1-ky_down))-repmat(pi/4,size(kybar))-theta;

theta_err=(theta_up-theta_down)./2;


for i=1:length(ky)
    
    if n_nans_x(i)>=5 || n_nans_y(i)>=5
        
        kxbar(i)=NaN;
        kybar(i)=NaN;
        theta(i)=NaN;
    end
        
      
end

% kx1=q1;
% ky1=sqrt(2)*q7+q1;
% 
% k_arc1=[kx1', ky1'];
% 
% kx2=(q3-q7)./(sqrt(2));
% ky2=(q3+q7)./(sqrt(2));
% 
% k_arc2=[kx2', ky2'];
% 
% 
% kx=(kx1+kx2)./2;
% ky=(ky1+ky2)./2;

% 
% quarter_circle=@(a,x)...
%     a^2 - x.^2;
% 
% circle_fit=fit(kxbar,kybar,quarter_circle);








figure
% plot(kx1,ky1,'ok',ky1,kx1,'ok')
% hold on
% plot(kx2,ky2,'or',ky2,kx2,'or')
ploterr(kxbar,kybar,kxstdev,kystdev,'or');
hold on
ploterr(kybar,kxbar,kystdev,kxstdev,'or');

hold on
xlim([0 1])
ylim([0 1])
axis square
plot([0 1], [1 0], '-k')


figure 

errorbar(energies.*1000,theta,theta_err,'ok');
hold on 
errorbar(-energies.*1000,theta,theta_err,'ok');%,energies.*1000,-theta,'ok',-energies.*1000,-theta,'ok');
ylim([ 0 pi/4]);
xlim([-80 80]);

end

