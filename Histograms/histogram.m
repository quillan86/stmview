function [fh varargout] = histogram(fdata,nbins)
[sx sy sz] = size(fdata);
[n x] = hist(reshape(fdata,sx*sy*sz,1),nbins);

fh = figure('Color',[0 0 0]);
bar(x,n./sum(n)*100,1);
set(gca,'Color','black','FontSize',14);
set(gca,'XColor','white')
set(gca,'YColor','white')
ylabel('% occurence');
xlabel('Bin Value');
varargout{1} = n;
varargout{2} = x;
end
