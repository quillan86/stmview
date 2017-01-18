function map_sspline(data,res,tol)

if isstruct(data)
    map = data.map;
    e = data.e*1000;
    
else
    map = data;
    e = 1:size(map,3);
end

[nr, nc, nz] = size(map);
if nz < 2
    display('Not Enough Point for Spline');
    return;
end

new_map = zeros(nr,nc,nz);

for i = 1:nr
    for j = 1:nc
        new_map(i,j,:) = spline_(e,y,res,tol);
    end
end

[yy1] = spaps(e,y,tol);

val1 = fnval(yy1,xx);




end