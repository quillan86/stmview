function holographic_map(data,Gvec)
[nr,nc,nz] = size(data.map);
data_FT1 = fourier_transform2d(data,'none','complex','ft');
data_FT2 = data_FT1; data_FT2.map = conj(data_FT2.map);

holo_data = data_FT1;
holo_data.map = (data_FT1.map.*circshift(data_FT2.map,[1*(535-454),1*(373-454)]));
r_holo = mean(mean(abs(real(holo_data.map))));
i_holo = mean(mean(abs(real(imag(holo_data.map)))));

phase = squeeze((r_holo-1i*i_holo)./abs(r_holo-1i*i_holo));
phase_map = ones(nr,nc,nz);
for i = 1:nz
    phase_map(:,:,i) = phase(i)*phase_map(:,:,i);
end

holo_data.map = imag(holo_data.map.*phase_map);
%holo_data.map = circshift(holo_data.map,[535-454,373-454]);
IMG(holo_data);


end