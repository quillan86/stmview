function [  ] = plot_fits_bscco( lc_fit_object ,offset)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here


lor_exp_bg=@(a,b,c,d,e,f,x)...
    a*exp(-b.*x)+c+d./((x-e).^2+f^2);

G=2*pi / 3.55;

figure

hold on


j=1;
for i=1:length(lc_fit_object.e)
    
    params=lc_fit_object.params{i};
    
    fit_flag=params.fit_or_not;
    
    
    if fit_flag==1
        
       x_ind=find( lc_fit_object.r >= params.lower  &  lc_fit_object.r <= params.higher);
       x_data=lc_fit_object.r(x_ind);
       y_data=lc_fit_object.cut(x_ind,i);
       
       lower=params.lower;
       higher=params.higher;
       
       q1_fit=fit(x_data,y_data,lor_exp_bg,...
'StartPoint', [params.a]...
);

y_data=(y_data+repmat(offset*(j-1),size(y_data)));

    
    vals=coeffvalues(q1_fit);
       
       plot(y_data,x_data ./G,'.w');
       
plot(lor_exp_bg(vals(1),vals(2),vals(3),vals(4),vals(5),vals(6),linspace(lower,higher,200))+repmat(offset*(j-1),size(linspace(lower,higher,200))),linspace(lower,higher,200) ./G,'r');
       
       j=j+1;
       clear x_ind x_data y_data vals q1_fit
    end
       
        
        clear params fit_flag
        
        
       
        
end
    
    
    
    
    hold off
    
    
    pbaspect([5 1 1]);
    
    ylim([0 0.6]);







end

