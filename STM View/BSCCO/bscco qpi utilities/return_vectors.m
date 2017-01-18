function [ q ] = return_vectors( params )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here



switch params.fit_type
    
    case 1
        
        q=[params.vals(5) NaN NaN];
        
    case 2 
        q=[params.vals(5) params.vals(8) NaN];
        
    case 3
        q=[params.vals(5) params.vals(8) params.vals(11)];
    
    
end


end

