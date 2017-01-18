function plot_grad_color(color_level,colormaps,x,y,varargin)
figure;

colormap(colormaps);
scatter(x,y,10,color_level,'filled'); hold on;
if nargin > 4
    x2 = varargin{1};
    y2 = varargin{2};
    scatter(x2,y2,10,fliplr(color_level),'filled');
end
end