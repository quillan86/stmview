function [xx yy] =  extract_points(img,r,color_map,clbnd)
figure; imagesc(r,r,img); axis equal;
hold on;
button = 0;
counter = 1;
while button ~=  3
    [x y b] = ginput(1);
    if b == 1
        plot(x,y,'rx');
        hold on;
        xx(counter) = x; yy(counter) = y;
        counter = counter + 1;
    elseif b == 3
        break;
    end
end
   figure; plot(yy,xx,'rx'); 
end