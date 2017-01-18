


lor_exp_bg=@(a,b,c,d,e,f,x)...
    a*exp(-b.*x)+c+d./((x-e).^2+f^2);





       lower=[0.01 0.01  0.01  0.01  0.01  0.01 0.01 0.01 0.01  0.01  0.01  0.01  0.01  0.01  0.01 ] ;
       higher=[1 1 1 1 1 1 1 1 1 1 1 1 1 1 1];
       
       x_ind=find( cut.r >= lower  &  cut.r <= higher);


for i=1:length(cut.e);
    
       x_ind=find( cut.r >= lower(i)  &  cut.r <= higher(i));
       x_data=cut.r(x_ind);
       y_data=cut.cut(x_ind,i);
       
    
    
    q1_fit{i}=fit(x_data,y_data,lor_exp_bg,...
'StartPoint', [145,3,15,0.0625,0.477,0.025]...
);
    
    q1_vals{i}=coeffvalues(q1_fit{i});
    
    clear x_data y_data
    
    q(i)=q1_vals{i}(5);
    
    
    
end


figure

plot(cut.e*1000,q ./ (2*pi / 3.55) ,'ok');
xlabel('E / mV');
ylabel('k / 2*pi / a_{0}') ;
