function map = circle_map(dim,lyr)
%map = zeros(dim,dim,lyr);
cr = dim/2; cc = dim/2;

r = 1:lyr;
r = r*15;

[X Y] = meshgrid(-dim/2+1:dim/2,-dim/2+1:dim/2);
R = sqrt(X.^2 + Y.^2);
R = sqrt(5*X.^2 + Y.^2);
for i = 1:lyr
map(:,:,i) = exp(-(R - r(i)).^2/5);
end
%img_plot2(z);
    
end