function [ vals] = double_peak_exp_bg( data,layer,lower,higher ,a,f,ha )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here


x_ind=find( data.r >= lower  &  data.r <= higher);
       
       
      
       
       
      
       
       x_data=data.r(x_ind);
       y_data=data.cut(x_ind,layer);
       
       
    d_lor_exp_bg@(a,c,d,e,f,g,h,l,x)...
    a.*x+c+d./((x-e).^2+f^2)+g./((x-h).^2+l^2);

q_fit=fit(x_data,y_data,d_lor_lin_bg,...
'StartPoint', [a(1),a(2),a(3),a(4),a(5),a(6),a(7),a(8),a(9)]...
);



vals=coeffvalues(q_fit);

figure(f)

axes(ha)
       
       
      plot(linspace(lower,higher,200),d_lor_lin_bg(vals(1),vals(2),vals(3),vals(4),vals(5),vals(6),vals(7),vals(8),vals(9),linspace(lower,higher,200)),data.r,data.cut(:,layer),'ok');
       xlim([min(data.r) max(data.r)]);
       






end

