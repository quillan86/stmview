function img_plot2(image,varargin)
in_len = length(varargin);
%Cmap = open('/Users/MHamidian/Documents/Research/STM Analysis Code/STM View/Color Maps/Blue2.mat');
%load_color;
if in_len == 1 && ~isempty(varargin{1})
    color = varargin{1};
    title = '';
elseif in_len == 2 && ~isempty(varargin{1}) && ~isempty(varargin{2})
    color = varargin{1};
    title = varargin{2};
elseif isempty(varargin)
    %color = Cmap.blue2;
    color = get_color_map('Blue2');
    title = '';
end
    
figure('Position',[150 150 550 550],'Name',title,'NumberTitle','off');
imagesc(image); shading flat; axis off; colormap(color);
set(gca,'Position', [0 0 1 1]);
axis equal;
end

