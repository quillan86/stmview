function [binval,A] = bin_plot(img_to_bin,data,nbin)

[bin_img, binval] = bin_map(img_to_bin,nbin,min(min(img_to_bin)),max(max(img_to_bin)));

%A = zeros(nbin);

for i = 1:nbin
    tmp = (bin_img == binval(i));
    A(i) = mean(data(tmp));
end

figure('Color',[0 0 0]); 
plot(binval,A,'yx','MarkerSize',10); 
set(gca,'Color','black','FontSize',14);
set(gca,'XColor','white')
set(gca,'YColor','white')
xlim([min(binval) max(binval)]);


end