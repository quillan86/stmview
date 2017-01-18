function ppt_plot(x,y,varargin)
plot(x,y,'LineWidth',1.5,varargin{:});
f = gcf;
set(f,'Color',[0 0 0]);
h = gca;
set(h,'Color',[0 0 0]);
set(h,'FontSize',14);
set(h,'XColor',[1 1 1]);
set(h,'YColor',[1 1 1]);
end