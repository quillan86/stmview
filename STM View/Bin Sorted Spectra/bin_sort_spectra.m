function [spectra] = bin_sort_spectra(binval,bin_img,data)
n_spectra = size(binval',1);
[nr nc nz] = size(data.map);
spectra = zeros(nz,n_spectra);
%new_map = zeros(sy,sx,n_spectra);

for n=1:n_spectra
    [tmpr tmpc] = find(bin_img == binval(n));
    nspec = size(tmpr);    
    for i = 1:nspec(1)
        spectra(:,n) = spectra(:,n) + squeeze(squeeze(data.map(tmpr(i),tmpc(i),:)));
    end
    if nspec(1) > 0
        spectra(:,n) = spectra(:,n)/(nspec(1));
    end
    %tmp = (data_source == binval(n)) ;
    %new_map_g(:,:,n) = tmp.*data_source;
    %new_map_ct(:,:,n) = tmp.*ctmap;
end
%colormap(get_color_map('PurpleWhiteCopper'));
%cc = get_color_map('PurpleWhiteCopper');
%cc = cc(:,round(linspace(1,length(cc),n_spectra)));
cc = get_color_map('Defect0');
[sz1, sz2] = size(cc);
cc_interp = [interp1(1:sz1,cc(:,1),linspace(1,sz1,n_spectra)); interp1(1:sz1,cc(:,2),linspace(1,sz1,n_spectra)); interp1(1:sz1,cc(:,3),linspace(1,sz1,n_spectra))];
cc_interp = cc_interp';
figure; 
%plot(data.e*1000,spectra(:,1:n_spectra),'Linewidth',2)
for i = 1:n_spectra
    plot(data.e*1000,spectra(:,i),'Linewidth',2,'Color',cc_interp(i,:));
    hold on;
end
    
