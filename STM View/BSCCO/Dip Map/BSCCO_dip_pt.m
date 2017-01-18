%find dip after on spectrum on either positive or negative side with
%indexing such energy(1) is the furthest away from zero bias
function [dip_val dip_energy] = BSCCO_dip_pt(spectrum,energy,peak_val_ind,smooth_width)
 pp = []; index = [];
 end_pt = peak_val_ind;
 
 if energy(1) > 0 %postive side spectrum
    x = energy(1:end_pt);
else
    x = -1*energy(1:end_pt); %negative side spectrum
 end
 y = smooth(spectrum(1:end_pt),smooth_width);
 %figure; plot(x,y,'g');
 y_diff = mean(y) - y;
 [pp index] = findpeaks(y_diff);
 if ~isempty(pp)
     p = pp(end); ind = index(end);
     if (p < 0) && (size(pp,1) > 1)
         p = pp(end-1);
         ind = index(end-1);
     end     
     dip_energy = x(ind);
     dip_val = p;     
 else
     dip_energy = 0;
     dip_val = 0;
 end
 if energy(1) < 0
     dip_energy = -1*dip_energy;
 end
% figure; plot(energy,spectrum); hold on; plot([-dip_energy -dip_energy],get(gca,'ylim'),'r');
end