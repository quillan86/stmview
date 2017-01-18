function [ ] = Amp_map_real_numbers(Ox,Oy,dw_pixels,filter_size,bragg_coord)

[nr,nc,nz] = size(Ox.map);

lattice_constant = (2*pi /(sqrt(2)*bragg_coord));

% if mod(ni,2)==1
    
    origin_pixel=(nr+1)/2;
    
% else
%     
%     error('not odd number of pixels');
%     
% end

no_filter = size(dw_pixels,1)+1;

centre_pixels = vertcat(dw_pixels,[origin_pixel,origin_pixel]);


for i = 1:no_filter
    if i == no_filter
        in_data = Ox;
        in_data.map = Ox.map + Oy.map;
    else
        in_data = Ox;
        in_data.map = Ox.map - Oy.map;
    end
    
    complex_FT = fourier_transform2d_test(in_data,'none','complex','ft');
        
    [filtered_FT,remainder_FT] = create_gaussian_mask_norm(complex_FT,centre_pixels(i,:),filter_size);
    
    test=filtered_FT;
    test.map=abs(test.map);
    
    IMG(test);
    
    filtered_image = fourier_transform2d(filtered_FT,'none','complex','ift');
    Amp_map = filtered_image;
    Amp_map.r = Amp_map.r-repmat(Amp_map.r(1),size(Amp_map.r));
    
    
    if i ~= no_filter
        wavevector(i) = abs(complex_FT.r(centre_pixels(i,1))) / bragg_coord ;
    end
    
    filter_size_output = (1 / (complex_FT.r(filter_size+1)-complex_FT.r(1))) /lattice_constant;
    unit_cell_pixels = ((2*pi /( sqrt(2)*bragg_coord)) / in_data.r(2))^2;
    
    if i == no_filter
        Amp_map.name = 'Mean Map';
        Amp_map.map = abs(Amp_map.map).*(0.5*unit_cell_pixels);
    else
        Amp_map.name = strcat('Amp Map ', num2str(i));
        Amp_map.map = abs(Amp_map.map).*(unit_cell_pixels);
    end
    
    IMG(Amp_map);
    
end

for i = 1:(no_filter-1)        
    display(strcat('Wave-vector ',num2str(i),': ', num2str(wavevector(i))));
    display(strcat('Filter Size: ', num2str(filter_size_output), ' unit cells'));
    display(strcat('Lattice Constant: ', num2str(lattice_constant)));
    display(strcat('FOV Size: ', num2str(max(Ox.r))));
end

end