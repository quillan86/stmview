% take a polar plot and assuming that the y-axis gives theta from 0 to 2pi,
% average together 2pi/n segments.  n needs to be a power of 2
function new_polar_data = polar_symmetrize(polar_data,n)
if n == 0
    display('Invalid');
    new_polar_data = [];
    return;
elseif n==1
    new_polar_data = polar_data;
    return;
else
    %check to see if n is a power of 2.  If not, find closest power of 2
    N = round(log2(n));
    m = 2^N; % map divides into m pieces instead of n in case n is not a power of 2
end

if isstruct(polar_data)
    map = polar_data.map;
else
    map = polar_data;
end
[nr nc nz] = size(map);
new_map = zeros(nr,nc,nz);
avg_section = zeros(nr/m,nc,nz);
divs = nr/m;
for i = 2:m
    tmp = map(((i-1)*divs+1):i*divs,:,:);
    avg_section = avg_section + tmp ;        
end
avg_section = avg_section/(m-1);
for i = 1:m
    new_map(((i-1)*divs+1):i*divs,:,:) = avg_section;        
end
if isstruct(polar_data)
    new_polar_data = polar_data;
    new_polar_data.map = new_map;
    new_polar_data.var = [polar_data.var '_polar_sym'];
    new_polar_data.ops{end+1} = ['polar average over ' num2str(m) ' sections'];
    img_obj_viewer2(new_polar_data);
    
else
    new_polar_data = new_map;
end
end