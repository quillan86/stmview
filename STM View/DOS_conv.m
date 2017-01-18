function [d_I,d_e1,I,e1] = DOS_conv(dos1,dos2,e1,e2)

mx_n = max(length(e1),length(e2));
mn_n = min(length(e1),length(e2));

md1 = floor(length(e1)/2);
md2 = floor(length(e2)/2);

for i = 1:mn_n
    d = 1;    
    if i > md1
        d = -1;      
    elseif i == md1
        d = 1;
    end
    
    dosp = dos1.*circshift(dos2,(i-md1));
    I(i) = d*sum(dosp(i:d:md1));
    %l = length(dosp(i:d:md1)); 
end   
%figure; plot(e1,II);
[d_I,d_e1] = num_der2b(1,I,e1);
%figure; plot(d_e1,d_I);
%hold on; plot(e1,dos1,'r');

end