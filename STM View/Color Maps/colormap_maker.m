function new_cmap = colormap_maker(col1,col2,col3,size)
%makes a color map by linearly interpolation between 3 colors equal spaced
%apart
if mod(size,2) == 0
    mid_p = size/2;
else
    mid_p = size/2 + 1;
end

r_top = linspace(col1(1),col2(1),mid_p);
g_top = linspace(col1(2),col2(2),mid_p);
b_top = linspace(col1(3),col2(3),mid_p);

r_bot = linspace(col2(1),col3(1),mid_p);
g_bot = linspace(col2(2),col3(2),mid_p);
b_bot = linspace(col2(3),col3(3),mid_p);

r = [r_top r_bot];
g = [g_top g_bot];
b = [b_top b_bot];

new_cmap = [r; g; b]';

%figure; colormap(new_cmap)
%plot(1,1);

end