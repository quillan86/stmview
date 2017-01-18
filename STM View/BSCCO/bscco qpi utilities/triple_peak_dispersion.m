function [ energies,q1,q2 ,q3] = triple_peak_dispersion( lc_fit_object )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here


d_lor_exp_bg=@(a,b,c,d,e,f,g,h,l,m,n,p,x)...
    a*exp(-b.*x)+c+d./((x-e).^2+f^2)+g./((x-h).^2+l^2)+m./((x-n).^2+p^2);


for i=1:length(lc_fit_object.e);
    
    params=lc_fit_object.params{i};
    
    fit_flag=params.fit_or_not;
    
    if fit_flag == 1
    
       x_ind=find( lc_fit_object.r >= params.lower  &  lc_fit_object.r <= params.higher);
       x_data=lc_fit_object.r(x_ind);
       y_data=lc_fit_object.cut(x_ind,i);
       
    
    
    q1_fit{i}=fit(x_data,y_data,d_lor_exp_bg,...
'StartPoint', [params.a]...
);
    
    q1_vals{i}=coeffvalues(q1_fit{i});
    
   
    
    q1(i)=q1_vals{i}(5);
    q2(i)=q1_vals{i}(8);
    q3(i)=q1_vals{i}(11);
    
   
    
    else
        
        q1(i)=NaN;
        q2(i)=NaN;
        q3(i)=NaN;
        
    end
        
        
   
   
    
   
    

    
    
    clear x_ind x_data y_data params fit_flag
    
    
end


 energies=lc_fit_object.e; 



end

