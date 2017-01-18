function [omap infl_map] = BSCCO_omega_map_v5(data,gap_map,degree_poly,frac_peak,res)
%degree_poly = 4; frac_peak = 0.7; res = 100;
[nr nc nz] = size(data.map);
energy = data.e*1000;

% first find gap index
gap_index = zeros(nr,nc);
for i = 1:nr
    for j = 1:nc
        gap_index(i,j) = find_gap_ind(gap_map(i,j),energy);
    end
end
%load_color
%img_plot2(gap_index,Cmap.Defect1,'Gap Index');
 infl_map = zeros(nr,nc);
 omap = zeros(nr,nc);
 e = data.e*1000;
 map = data.map;
 h = waitbar(0,'Please wait...','Name','Omega Map Progress');
% 
isOpen = matlabpool('size') > 0;
if isOpen == 0 
   matlabpool(4);
end
for i=1:nr    
    parfor j=1:nc                
        if gap_index(i,j) ~= 0
            %x = data.e(1:gap_index(i,j))*1000; 
            x = e(1:gap_index(i,j)); 
            y = squeeze(squeeze(map(i,j,1:gap_index(i,j)))); 
            l_y = length(y);
            peak_val = y(end);
            left_min_ind = 15;
            min_val_ind = find(y(left_min_ind:l_y)==min(y(left_min_ind:l_y)))
            %if isempty(min_val_ind)
            %    infl_map(i,j) = -1;
            %else
                min_val_ind = min_val_ind + left_min_ind - 1;
                min_val = y(min_val_ind);
                infl_map(i,j) = BSCCO_gamma_pt_v4(y,x,min_val_ind,l_y,degree_poly,frac_peak,res);             
            %end
        end
    end
    waitbar(i/nr,h,[num2str(i/nr*100) '%']); 
end
% %matlabpool close;
close(h);
omap = abs(infl_map - abs(gap_map));
% omap(infl_map == 0) = 0;
load_color
img_plot2(omap,Cmap.Defect4);
end