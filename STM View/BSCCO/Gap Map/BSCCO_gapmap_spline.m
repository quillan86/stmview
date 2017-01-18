function [gmap_neg, neg_h, gmap_pos, pos_h] = BSCCO_gapmap_spline(data)
if isstruct(data)
    map = data.map;
    e = data.e*1000;
else
    map = data;
    e = 1:size(data,3);
end
[nr nc nz] = size(map);

gmap_neg = zeros(nr,nc);
neg_h = zeros(nr,nc);
gmap_pos = zeros(nr,nc);
pos_h = zeros(nr,nc);

for i = 1:nr
    i
    for j = 1:nc
        y = squeeze(squeeze(map(i,j,:)));
        [gmap_neg(i,j), neg_h(i,j), gmap_pos(i,j), pos_h(i,j)] = BSCCO_gap_val_spline(e,y);
    end
end
img_plot2(gmap_neg);
img_plot2(gmap_pos);
end