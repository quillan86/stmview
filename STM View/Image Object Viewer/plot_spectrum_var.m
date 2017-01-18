function plot_spectrum_var(data, varargin)
y = map_avg_spectrum(data);
x = data.e*1000;
% [nr nc nz] = size(data.map);
% lin_dim = nc*nr;
% err = zeros(1,nz);
% for i = 1:nz
%     lin_map = reshape(data.map(:,:,i),1,lin_dim);
%     err(i) = var(lin_map);
% end
err = map_lyr_std(data);
in_len = length(varargin);

if (in_len == 1 && ~isempty(varargin{1}))    
    col_mark = varargin{1};
    title = '';
elseif in_len == 2 && ~isempty(varargin{1}) && ~isempty(varargin{2})
    col_mark = varargin{1};
    title = varargin{2};
elseif isempty(varargin)
    col_mark = 'b';
    title = '';
else    
    col_mark = 'b';
    title = varargin{2};
end
figure('Position',[150 150 400 400],'Name',title);

errorbar(x,y,err,'r.','LineWidth',1,...
                'MarkerEdgeColor','k',...
                'MarkerFaceColor','g',...
                'MarkerSize',5);

hold on; plot(x,y,'b');

end