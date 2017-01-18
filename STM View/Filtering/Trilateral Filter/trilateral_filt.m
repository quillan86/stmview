function [img1]= trilateral_filt(img,winsize,sigma,m)
% This function defines the trilateral filtering which is modification over
% bilateral filter and can be used for both gaussian & impulse noise.
% winsize should be odd.
padnum=(winsize-1)/2;
win=fspecial('gaussian',winsize,sigma(1));
A=padarray(img,[padnum padnum],'symmetric','both');
img1=zeros(size(img));
[H,W]=size(img);
for pp=padnum+1:H+padnum+1-1    
    for qq=padnum+1:W+padnum+1-1
        % get local neighbouhood.
        imgwin1=A(pp-padnum:pp+padnum,qq-padnum:qq+padnum);
        % for intensity difference.
        Ws=exp(-(imgwin1-imgwin1(padnum+1,padnum+1).^2)/sigma(2)^2);
        %imgwin1=uint8(imgwin1);
        r=abs(imgwin1-imgwin1(padnum+1,padnum+1));
        ri=sort(r(:));
        ROAD = sum(sum(ri(1:m))); %rank ordered absolute difference (ROAD)
        Wi=exp(-(ROAD)/sigma(3)^2)          ;
        if(ROAD>sigma(4))
            j=1;
        else
            j=0;
        end        
        % defining weighing function.
        w=win*Ws^(1-j)*Wi^j;
        t=sum(sum(w));
        if(t>0)
            w=w/t;
        end
        imgwin1=double(imgwin1);
        img1(pp-padnum,qq-padnum)=sum(sum(w*imgwin1));
    end
end