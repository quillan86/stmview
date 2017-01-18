function new_data = energy_interp_map(data,n_pts)
if isstruct(data)
    map = data.map;
else
    map = data;
end

[nr, nc, nz] = size(map);

if n_pts == nz
    new_data = data;
    return;
end

[NR,NC,NZ] = meshgrid(1:nr,1:nc,1:nz);
[NR2,NC2,NZ2] = meshgrid(1:nr,1:nc,linspace(1,nz,n_pts));
new_map = interp3(NR,NC,NZ,map,NR2,NC2,NZ2,'spline');

if isstruct(data)
    new_data = data;
    new_data.map = new_map;
    new_data.e = interp1(1:nz,data.e,linspace(1,nz,n_pts));
    new_data.ave = avg_map(new_map);
    new_data.var = [new_data.var '_Eint'];
    new_data.ops{end+1} = ['New Energy Pixel Dimensions: ' num2str(nz) ' -> ' num2str(n_pts)];
    %IMG(new_data);
else
    new_data = new_map;
end