function img_scatter_plot(img,rgb)
[nr,nc] = size(img);
A = reshape(img,[nr*nc 1]);
[X,Y] = meshgrid(1:nr,1:nc);
X = reshape(X,[nr*nc 1]);
Y = reshape(Y,[nr*nc 1]);
%figure; 
scatter3(X,Y,A,'MarkerEdgeColor','k',...
        'MarkerFaceColor',rgb);
end