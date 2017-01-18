


  lor_exp_bg=@(a,b,c,d,e,f,g,h,l,x)...
    a*exp(-b.*x)+c+d./((x-e).^2+f^2)+g./((x-h).^2+l^2);


for i=1:10;
    
    x_data=cut.r(1:25);
    y_data=cut.cut(1:25,i);
    
    
    q1_fit{i}=fit(x_data,y_data,lor_exp_bg,...
'StartPoint', [145,3,15,0.0625,0.477,0.025, 0.0624, 0.41,0.025]...
);
    
    q1_vals{i}=coeffvalues(q1_fit{i});
    
    clear x_data y_data
    
    q1(i)=q1_vals{i}(5);
    
    q2(i)=q1_vals{i}(8);
    
    
    
end


figure

plot(cut.e(1:10)*1000,q1  ,'ok',cut.e(1:10)*1000,q2  ,'or');
xlabel('E / mV');
ylabel('k / 2*pi / a_{0}') ;
