function [ phi_map ] = modulation_phase(data,layer,coordinates,filtersize )

img=squeeze(data.map(:,:,layer));

q_px(1,1) = coordinates(1);
q_px(2,1) = coordinates(2);
q_px(1,2) = coordinates(3);
q_px(2,2) = coordinates(4);
filt_w = filtersize;

phi_map = phase_map(img,data.r,q_px,filt_w);
end