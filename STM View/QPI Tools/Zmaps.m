function Z = Zmaps(data)
[nr, nc, nz] = size(data.map);
nz = size(data.e,2);
if nz == 1
    disp('Z-map not possible: 1 layer only');
    return;
end

if ((abs(data.e(1)))==abs(data.e(end)))
    Z = data;       
    % Zmap only contains non-zero bias layers so layers = floor(nz/2)
    Z.map = zeros(nr,nc,floor(nz/2));   
    Z.e = abs(data.e(1:floor(nz/2)));
    for k = 1:floor(nz/2)
        if Z.e(1) > Z.e(end)
            display('poop')
            numer = data.map(:,:,k);
            denom = data.map(:,:,end-k+1); denom(denom == 0) = 10;
            Z.map(:,:,k) = numer./denom;                        
        else
            numer = data.map(:,:,end-k+1);
            denom = data.map(k); denom (denom == 0) = 10;
            Z.map(:,:,k) = numer./denom;                        
        end
    end
    Z.map = abs(Z.map);
    Z.ave = squeeze(mean(mean(Z.map)));
    Z.var = 'Z';
    Z.ops{end+1} = 'Zmap';
    IMG(Z);
else
    disp('Z-map not possible');
    return;
end
        
end