function [ energies,qs ] = single_peak_dispersion( lc_fit_object )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here


lor_exp_bg=@(a,b,c,d,e,f,x)...
    a*exp(-b.*x)+c+d./((x-e).^2+f^2);




for i=1:length(lc_fit_object.e);
    
    params=lc_fit_object.params{i};
    
    fit_flag=params.fit_or_not;
    
    if fit_flag == 1
    
       x_ind=find( lc_fit_object.r >= params.lower  &  lc_fit_object.r <= params.higher);
       x_data=lc_fit_object.r(x_ind);
       y_data=lc_fit_object.cut(x_ind,i);
       
            a_up=params.a .*3;
     a_low=params .a.*0.3;
      
    
    q1_fit{i}=fit(x_data,y_data,lor_exp_bg,...
'StartPoint', [params.a],...
'Upper',a_up,'Lower',a_low);
    
    q1_vals{i}=coeffvalues(q1_fit{i});
    
   
    
    qs(i)=q1_vals{i}(5);
    
   
    
    else
        
        qs(i)=NaN;
        
    end
        
        
   
   
    
   
    

    
    
    clear x_ind x_data y_data params fit_flag
    
    
end


 energies=lc_fit_object.e; 



end

