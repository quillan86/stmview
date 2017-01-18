function [  ] = plot_fits_bscco( lc_fit_object ,offset)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here


figure

hold on

for i=1:length(lc_fit_object.e)
    
    params=lc_fit_object.params{i};
    
    fit_flag=params.fit_or_not;
    
    
    if fit_flag==1
        
       x_ind=find( lc_fit_object.r >= params.lower  &  lc_fit_object.r <= params.higher);
       x_data=lc_fit_object.r(x_ind);
       y_data=lc_fit_object.cut(x_ind,i)
       y_data=y_data+repmat(offset,size(y_data));
       
       plot(x_data,y_data,'ok');
       clear x_ind x_data y_data 
    end
       
        
        clear params fit_flag
        
        
        hold off
        
    end
    
    
    
    
    
    
    
    
end






end

