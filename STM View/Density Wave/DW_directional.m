function DW_amplitude_v2(q_px,filt_w,data,opt)

% opt is for sFF s'FF dFF in arrary form [opt(1) opt(2) opt(3)]

[sum_Re_FTOxOy sum_Im_FTOxOy diff_Re_FTOxOy diff_Im_FTOxOy] = BSCCO_OxOy_sum_diff_map(data,0);

[Ox ,Oy, Cu_map] = BSCCO_sublattice_maps(data);
Re_FTCu = fourier_transform2d(Cu_map,'none','real','ft');
Re_FTCu.var = 'Re_FTCu';
Im_FTCu = fourier_transform2d(Cu_map,'none','imaginary','ft');
Im_FTCu.var = 'Im_FTCu';

[nr nc nz] = size(data.map);    
    mask1 = Gaussian2D(1:nr,1:nc,filt_w,filt_w,0,[q_px(1,1) q_px(2,1)],1);
    mask2 = Gaussian2D(1:nr,1:nc,filt_w,filt_w,0,[q_px(1,2) q_px(2,2)],1);       
    %img_plot2(mask1);
    %zoom(3);        
    [nr nc nz] = size(sum_Re_FTOxOy.map);
    
    FTCu_Q1 = Re_FTCu;
    FTCu_Q2 = Re_FTCu;
    FTCu_Q1.map = zeros(nr,nc,nz);
    FTCu_Q2.map = zeros(nr,nc,nz);
    
    sum_FTOxOy_Q1 = sum_Re_FTOxOy;
    sum_FTOxOy_Q2 = sum_Re_FTOxOy;
    sum_FTOxOy_Q1.map = zeros(nr,nc,nz);
    sum_FTOxOy_Q2.map = zeros(nr,nc,nz);    
    
    diff_FTOxOy_Q1 = diff_Re_FTOxOy;
    diff_FTOxOy_Q2 = diff_Re_FTOxOy;
    diff_FTOxOy_Q1.map = zeros(nr,nc,nz);
    diff_FTOxOy_Q2.map = zeros(nr,nc,nz);
    
    
    if opt(1) == 1
        for k = 1:nz
            FTCu_Q1.map(:,:,k) = Re_FTCu.map(:,:,k).*mask1 + 1i*Im_FTCu.map(:,:,k).*mask1;
            FTCu_Q2.map(:,:,k) = Re_FTCu.map(:,:,k).*mask2 + 1i*Im_FTCu.map(:,:,k).*mask2;
        end
        sff_DW_amp_Q1 = fourier_transform2d(FTCu_Q1,'none','amplitude','ift'); 
        sff_DW_amp_Q2 = fourier_transform2d(FTCu_Q2,'none','amplitude','ift'); 
        sff_DW_dir = sff_DW_amp_Q1;
        sff_DW_dir.map = (sff_DW_amp_Q1.map - sff_DW_amp_Q2.map)./(sff_DW_amp_Q1.map + sff_DW_amp_Q2.map);
        sff_DW_dir.var = 'sFF_DW_dir';
        sff_DW_dir.ave = avg_map(sff_DW_dir.map);
        IMG(sff_DW_dir);
    end
    
    if opt(2) == 1
        for k = 1:nz
            sum_FTOxOy_Q1.map(:,:,k) = sum_Re_FTOxOy.map(:,:,k).*mask1 + 1i*sum_Im_FTOxOy.map(:,:,k).*mask1;
            sum_FTOxOy_Q2.map(:,:,k) = sum_Re_FTOxOy.map(:,:,k).*mask2 + 1i*sum_Im_FTOxOy.map(:,:,k).*mask2;
        end
        spff_DW_amp_Q1 = fourier_transform2d(sum_FTOxOy_Q1,'none','amplitude','ift'); 
        spff_DW_amp_Q2 = fourier_transform2d(sum_FTOxOy_Q2,'none','amplitude','ift'); 
        spff_DW_dir = spff_DW_amp_Q1;
        spff_DW_dir.map = (spff_DW_amp_Q1.map - spff_DW_amp_Q2.map)./(spff_DW_amp_Q1.map + spff_DW_amp_Q2.map);
        spff_DW_dir.var = 's`FF_DW_dir';
        spff_DW_dir.ave = avg_map(spff_DW_dir.map);
        IMG(spff_DW_dir);
    end
    
    if opt(3) == 1
        for k = 1:nz
            diff_FTOxOy_Q1.map(:,:,k) = diff_Re_FTOxOy.map(:,:,k).*mask1 + 1i*diff_Im_FTOxOy.map(:,:,k).*mask1;
            diff_FTOxOy_Q2.map(:,:,k) = diff_Re_FTOxOy.map(:,:,k).*mask2 + 1i*diff_Im_FTOxOy.map(:,:,k).*mask2;
        end
        dff_DW_amp_Q1 = fourier_transform2d(diff_FTOxOy_Q1,'none','amplitude','ift'); 
        dff_DW_amp_Q2 = fourier_transform2d(diff_FTOxOy_Q2,'none','amplitude','ift'); 
        dff_DW_dir = dff_DW_amp_Q1;
        dff_DW_dir.map = (dff_DW_amp_Q1.map - dff_DW_amp_Q2.map)./(dff_DW_amp_Q1.map + dff_DW_amp_Q2.map);
        dff_DW_dir.var = 'dFF_DW_dir';
        dff_DW_dir.ave = avg_map(dff_DW_dir.map);
        IMG(dff_DW_dir);
    end
    
%    figure; plot(dff_DW_amp.e,dff_DW_amp.ave); 
%    hold on; plot(sff_DW_amp.e,sff_DW_amp.ave,'r'); 
%    hold on; plot(spff_DW_amp.e,spff_DW_amp.ave,'k'); 
end