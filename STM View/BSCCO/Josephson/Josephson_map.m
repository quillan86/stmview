function [Ic_map_pos, Vc_map_pos,Ic_map_neg, Vc_map_neg] = Josephson_map(data)
map = data.map;
e = data.e*1000;
[nr, nc, nz] = size(map);
Ic_map_pos = zeros(nr,nc);
Vc_map_pos = zeros(nr,nc);
Ic_map_neg = zeros(nr,nc);
Vc_map_neg = zeros(nr,nc);
for i = 1:nr
    i
    parfor j = 1:nc        
        y = squeeze(squeeze(map(i,j,:)));
        %[Ic_map(i,j), Vc_map(i,j)] = Josephson_current(e,y);        
        [Ic, Vc] = Josephson_current_v3(e,y);    
        Ic_map_pos(i,j) = Ic(1); Vc_map_pos(i,j) = Vc(1);
        Ic_map_neg(i,j) = Ic(2); Vc_map_neg(i,j) = Vc(2);
    end
end
img_plot2(Ic_map_pos);
title('Ic_map_pos');
img_plot2(Vc_map_pos);
title('Vc_map_pos');
img_plot2(Ic_map_neg);
title('Ic_map_neg');
img_plot2(Vc_map_neg);
title('Vc_map_neg');
end