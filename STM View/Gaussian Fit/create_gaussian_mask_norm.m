function [masked_map,remainder_map] = create_gaussian_mask_norm(data,centre_pixels,st_devs)

[nr,nc,nz]=size(data.map);

for i=1:nr    
    for j=1:nc
       mask(i,j) = gauss_masking_func_norm(centre_pixels(:,1), centre_pixels(:,2),st_devs,i,j);
    end
end

mask_3 = repmat(mask,[1,1,nz]) ./ repmat(max(max(mask)),[nr,nc,nz]);

masked_map = in_data;

remainder_map = in_data; 

masked_map.map = in_data.map.*mask_3;

factor=(ones(nr,nc,nz) - mask_3);

remainder_map.map = in_data.map.*factor ;


masked_map.ave = squeeze(squeeze(sum(sum(masked_map.map,1),2))) ./ squeeze(sum(sum(mask)));
remainder_map.ave = squeeze(squeeze(sum(sum(remainder_map.map,1),2))) ./ squeeze(sum(sum(factor(:,:,1))));

end

