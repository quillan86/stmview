function [ vals ] = single_lorentzian_ebg( data,layer,lower,higher,lower_disp,higher_disp ,a,f,ha,test)

x_ind=find( data.r >= lower  &  data.r <= higher);

a_up=a.*1.2;
a_low=a.*0.8;

x_data=data.r(x_ind);
y_data=data.cut(x_ind,layer);

lor_exp_bg=@(a,b,c,d,e,f,x)...
    a*exp(-b.*x)+c+d./((x-e).^2+f^2);

if test==0
    q1_fit=fit(x_data,y_data,lor_exp_bg,...
        'StartPoint', [a(1),a(2),a(3),a(4),a(5),a(6)] ,...
        'Upper',a_up,'Lower',a_low);   
    vals=coeffvalues(q1_fit);
else
    vals=a;
end

figure(f)

axes(ha)


plot(linspace(lower,higher,200),lor_exp_bg(vals(1),vals(2),vals(3),vals(4),vals(5),vals(6),linspace(lower,higher,200)),data.r,data.cut(:,layer),'ok');
xlim([lower_disp higher_disp]);



end

