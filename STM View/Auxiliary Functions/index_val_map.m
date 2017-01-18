% given a map M(rx,ry) whose values are in the span of discretely spaced 
%array E, make a new map who value at each pixel is the index of the value 
%closest to the value of the pixel

function index_map = index_val_map(map,E)
[nr nc] = size(map);
index_map = zeros(nr,nc);
for i = 1:nr
    for j = 1:nc
        tmp = find_nearest_index(E,map(i,j));
        if ~isempty(tmp)
            index_map(i,j) = tmp;
        end
    end
end
end