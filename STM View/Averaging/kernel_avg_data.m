%%%%%%%
% CODE DESCRIPTION: The values of the data image are spatially averaged
% over regions of equal value in the kernel image (after binning).  The
% kernel image could be the SM phase in BSCCO, for example.
%
%       INPUT: data - contains image on which to perform average, can be a
%                     data object or single layer image
%
%               kernel_img - contains image which is binned and whose equal
%                           valued regions determined how to spatially 
%                           average the data image
%
%       OUTPUT: data object containing, 
%                       - binned kernel image values (vector)
%                       - spatially averaged data image over binned kernel
%
% CODE HISTORY
%
% 131026 - Created
%
%%%%%%%
function avg_data = kernel_avg_data(data,kernel_img,n_bin)
if isstruct(data)
    map = data.map;
else
    map = data;
end
[nr nc nz] = size(map);
[bin_img bin_val] = bin_map(kernel_img,n_bin,min(min(kernel_img)),max(max(kernel_img)));
%img_plot2(bin_img); histogram(bin_img,500);
avg_data.bins = bin_val;
avg_data.avg = zeros(nz,length(bin_val));
for i = 1:length(bin_val)
    A(:,:,i) = (bin_img == bin_val(i));
    tot = sum(sum(A(:,:,i)));
    for k = 1:nz
        avg_data.avg(k,i) = sum(sum(map(:,:,k).*A(:,:,i)))/tot;
    end
end
figure('Color',[0 0 0]); 
plot(avg_data.bins,avg_data.avg(1,:),'yx','MarkerSize',10); 
set(gca,'Color','black','FontSize',14);
set(gca,'XColor','white')
set(gca,'YColor','white')
xlim([min(bin_val) max(bin_val)]);
end