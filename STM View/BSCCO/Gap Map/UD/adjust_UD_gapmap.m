function new_gapmap =  adjust_UD_gapmap(gapmap,data,gap_bnd)

map = data.map;
[nr nc] = size(gapmap);
new_gapmap = gapmap;
x = data.e*1000;

isOpen = matlabpool('size') > 0;
if isOpen == 0
    matlabpool(4);
end

for i = 1:nr
    i
    parfor j = 1:nc
        if gapmap(i,j) > gap_bnd
            y = squeeze(map(i,j,:));
            [sgap_map dgap_map] =  BSCCO_UD_gap_edge_find_basic(90,150,y,x);
            new_gapmap(i,j) = dgap_map;            
        end
    end
end
load_color;
img_plot2(new_gapmap);
colormap(Cmap.Defect4);
end
