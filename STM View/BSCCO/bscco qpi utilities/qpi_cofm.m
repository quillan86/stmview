function [ q ] = qpi_cofm( map,points,sizes)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here


for i=1:length(points)
    
    if points(i,1)~=0
        
     subset=squeeze(map.map(points(i,1)-sizes(i,1):points(i,1)+sizes(i,1),points(i,2)-sizes(i,2):points(i,2)+sizes(i,2),i) ) ; 
      ry=map.r(  points(i,1)-sizes(i,1):points(i,1)+sizes(i,1));
      rx=map.r(points(i,2)-sizes(i,2):points(i,2)+sizes(i,2)) ;
      
      [q(i,1), q(i,2)]=center_of_mass(subset,rx,ry);
        
    else
        
       q(i,:)=[NaN NaN]; 
    end
    
    
    
    
end




end

