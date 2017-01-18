function [sgap dgap] = BSCCO_dynes_map(data)
[nr nc nz] = size(data.map);
sgap = zeros(nr,nc);
dgap = zeros(nr,nc);
isOpen = parpool('size') > 0;
if isOpen == 0
    parpool(4);
end
for i = 1:nr
    i
    parfor j = 1:nc
        [sgap(i,j) dgap(i,j)] =  find_gap_edge_dynes(data,i,j);
    end
end
img_plot2(sgap);
img_plot2(dgap);
end