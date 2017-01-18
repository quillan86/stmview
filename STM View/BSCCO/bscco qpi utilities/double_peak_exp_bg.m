function [ vals] = double_peak_exp_bg( data,layer,lower,higher ,lower_disp,higher_disp,a,f,ha ,test)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here


x_ind=find( data.r >= lower  &  data.r <= higher);
       
       
       a_up=a.*3;
     a_low=a.*0.3;
       
       
      
       
       x_data=data.r(x_ind);
       y_data=data.cut(x_ind,layer);
       
   
    d_lor_exp_bg=@(a,b,c,d,e,f,g,h,l,x)...
    a*exp(-b.*x)+c+d./((x-e).^2+f^2)+g./((x-h).^2+l^2);
 lor=@(a,b,c,x)...
    a./((x-b).^2+c^2);

 if test==0   
q_fit=fit(x_data,y_data,d_lor_exp_bg,...
'StartPoint', [a(1),a(2),a(3),a(4),a(5),a(6),a(7),a(8),a(9)],...
'Upper',a_up,'Lower',a_low);



vals=coeffvalues(q_fit);

 else
     
     vals=a;
     
 end

figure(f)

axes(ha)
       
       
      plot(linspace(lower,higher,200),d_lor_exp_bg(vals(1),vals(2),vals(3),vals(4),vals(5),vals(6),vals(7),vals(8),vals(9),linspace(lower,higher,200)),'-k',data.r,data.cut(:,layer),'ok');
      hold on
      
      
      plot(linspace(lower,higher,500),lor(vals(4),vals(5),vals(6),linspace(lower,higher,500)),'-r');
      plot(linspace(lower,higher,500),lor(vals(7),vals(8),vals(9),linspace(lower,higher,500)),'-b');
      
      hold off
      
      xlim([lower_disp higher_disp]);
       






end

