function [sgap_map dgap_map] = BSCCO_UD_gapmap(data) 
[nr nc nz] = size(data.map);
sgap = zeros(nr,nc);
dgap = zeros(nr,nc);
map = data.map;
x = data.e*1000;
isOpen = matlabpool('size') > 0;
if isOpen == 0
    matlabpool(4);
end
low_bnd = 30;
up_bnd = 180;
%nr = 10;
%nc = 10;
for i = 1:nr
   i
    parfor j = 1:nc
        %[i j]
        y = squeeze(map(i,j,:));
       [sgap_map(i,j) dgap_map(i,j)] =  BSCCO_UD_gap_edge_find_basic(low_bnd,up_bnd,y,x);
    end
end
img_plot2(sgap_map);
title('sgap')
img_plot2(dgap_map);
title('dgap')
end