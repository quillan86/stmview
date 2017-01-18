function [ q ] = dispersion( lc_fit_data )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here



for i=1:length(lc_fit_data.e);
    
    
   q(i,:)=return_vectors(lc_fit_data.params{i}); 
    
    
end



end

