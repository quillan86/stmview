%%%%%%%
% CODE DESCRIPTION: Given two single layer maps or images, the program
%                   determined if they have any significant cross
%                   correlation.  Given that two images may have different
%                   pixel densities for a given length scale the program
%                   account for this by adjusting the pixel density to the
%                   highest one.
%
% INPUT: data1 - first image or map
%        data2 = second image or map
%
% OUTPUT: 
%
% CODE HISTORY
%
% 140702 MHH  - Created

%%%%%%%%
function max_c = register_image(data1,data2)

len1 = max(data1.r) - min(data1.r);
len2 = max(data2.r) - min(data2.r);

[nr1 nc1 nz1] = size(data1.map);
[nr2 nc2 nz2] = size(data2.map);

% pixel density
px_density1 = nr1/len1;
px_density2 = nr2/len2;

%adjust image pixel dimensions so that they are equivalent between each
%other (otherwise cross correlation won't know the length scales are)

px_density_ratio = px_density1/px_density2;

if px_density_ratio > 1
    map2 = pix_dim(data2.map,round(nr2*px_density_ratio));
    map1 = data1.map;
elseif px_density_ratio <= 1
    map1 = pix_dim(data1.map,round(nr1/px_density_ratio));
    map2 = data2.map;
end

if len2 > len1
    c = normxcorr2(map1,map2);
elseif len1 >= len2
    c = normxcorr2(map2,map1);
end

[max_c, imax] = max(abs(c(:)));
[ypeak, xpeak] = ind2sub(size(c),imax(1));
figure; imagesc(c); axis equal;
hold on; plot(xpeak,ypeak,'o','MarkerFaceColor',[0 0 0],...
                'MarkerSize',5);

end