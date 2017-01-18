function gmaps = BSCCO_gap_map_v2(data,start_energy_ind,end_energy_ind,...
                                smoothness,map_optn,dbl_pk_optn,dbl_pk_percent,pk_rng_optn)

gmaps = [];
[nr nc nz] = size(data.map);

x = 1000*data.e(start_energy_ind:end_energy_ind);
map = data.map(:,:,start_energy_ind:end_energy_ind);
x1 = 0; x2 = 0;
pos_optn = 0; neg_optn = 0; %switches to evaluate pos and neg maps
% map calculation options - NEGATIVE DELTA & POSITIVE DELTA
if map_optn(2) == 1 || map_optn(1) == 1 % yes to positive map
    x1 = x(x > 0);
    if ~isempty(x1)
        map1 = map(:,:,(x>0));
        pos_optn = 1;
        gap_map1 = zeros(nr,nc); %positive gap
        dbl_peak_pos1 = zeros(nr,nc);
        peak_mag1 = zeros(nr,nc);
    else
        display('No Positive Side to Find Gap in Specified Energy Range');
        return;
    end
else
    map1 = zeros(1,1,1);
    gap_map1 = 0;
    dbl_peak_pos1 = 0;
    peak_mag1 = 0;
end
if map_optn(3) == 1 || map_optn(1) == 1% yes to negative map
    x2 = x(x < 0);
    if ~isempty(x2)
        map2 = map(:,:,(x<0));
        neg_optn = 1;
        gap_map2 = zeros(nr,nc); %negative gap
        dbl_peak_pos2 = zeros(nr,nc);
        peak_mag2 = zeros(nr,nc);
    else
        display('No Negative Side to Find Gap in Specified Energy Range');
        return;
    end
else
    map2 = zeros(1,1,1);
    gap_map2 = 0;
    dbl_peak_pos2 = 0;
    peak_mag2 = 0;
end

% rearrange spectrum starting from small to big energies
if x(1) > x(end)
    x1 = x1(end:-1:1);
    map1 = map1(:,:,end:-1:1);
    x2 = x2(end:-1:1);
    map2 = map2(:,:,end:-1:1);
end

h = waitbar(0,'Please wait...','Name','Gap Map Progress');
[nr1] = size(map1,1);
[nr2] = size(map2,1);

isOpen = matlabpool('size') > 0;
if isOpen == 0 
    matlabpool(4);
end
for i = 1:nr
    map1_rdx = squeeze(map1(min(i,nr1),:,:));
    map2_rdx = squeeze(map2(min(i,nr2),:,:));
    for j = 1:nc
        if pos_optn == 1
            %find +ve edge
            y1 = squeeze(squeeze(map1_rdx(j,1:end)))';                        
            [peak_loc peak_mag dbl_peak_check] = BSCCO_OD_gap(y1,x1,smoothness,dbl_pk_optn,dbl_pk_percent,pk_rng_optn);         
            gap_map1(i,j) =  peak_loc;
            peak_mag1(i,j) = peak_mag;
            dbl_peak_pos1(i,j) = dbl_peak_check;
          
        end
        if neg_optn == 1        
            %find -ve edge
            y2 = squeeze(squeeze(map2_rdx(j,1:end)))';                            
            [peak_loc peak_mag dbl_peak_check] = BSCCO_OD_gap(y2,x2,smoothness,dbl_pk_optn,dbl_pk_percent,pk_rng_optn);          
            gap_map2(i,j) =  peak_loc;
            peak_mag2(i,j) = peak_mag;
            dbl_peak_pos2(i,j) = dbl_peak_check;   
        end
    end
    waitbar(i / nr,h,[num2str(i/nr*100) '%']);    
end
close(h);
%matlabpool close;

gmaps.pos = gap_map1; gmaps.neg = gap_map2; gmaps.avg = 0;
% average map option
if map_optn(1) == 1
    gap_map_avg = (abs(gap_map1) + abs(gap_map2))/2;  
    gmaps.avg = gap_map_avg;
end

 load_color
 img_plot2(gap_map1,Cmap.Defect1,'BSCCO Gap Map +ve');
 img_plot2(gap_map2,Cmap.Defect1,'BSCCO Gap Map -ve');
end
