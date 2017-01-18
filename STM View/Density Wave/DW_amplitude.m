function dff_DW_amp = DW_amplitude(q_px,filt_w,data)

[sum_Re_FTOxOy sum_Im_FTOxOy diff_Re_FTOxOy diff_Im_FTOxOy] = BSCCO_OxOy_sum_diff_map(data,0);
[nr nc nz] = size(data.map);
    %mask1 = Gaussian2D_v2(1:nr,1:nc,filt_w,filt_w,0,[q_px(1,1) q_px(2,1)],1);
    %mask2 = Gaussian2D_v2(1:nr,1:nc,filt_w,filt_w,0,[q_px(1,2) q_px(2,2)],1);       
    mask1 = Gaussian2D(1:nr,1:nc,filt_w,filt_w,0,[q_px(1,1) q_px(2,1)],1);
    mask2 = Gaussian2D(1:nr,1:nc,filt_w,filt_w,0,[q_px(1,2) q_px(2,2)],1);       
    %img_plot2(mask1);
    %zoom(3);        
    [nr nc nz] = size(sum_Re_FTOxOy.map);
    diff_FTOxOy_Q1 = diff_Re_FTOxOy;
    diff_FTOxOy_Q2 = diff_Re_FTOxOy;
    diff_FTOxOy_Q1.map = zeros(nr,nc,nz);
    diff_FTOxOy_Q2.map = zeros(nr,nc,nz);
    for k = 1:nz        
        diff_FTOxOy_Q1.map(:,:,k) = diff_Re_FTOxOy.map(:,:,k).*mask1 + 1i*diff_Im_FTOxOy.map(:,:,k).*mask1;
        diff_FTOxOy_Q2.map(:,:,k) = diff_Re_FTOxOy.map(:,:,k).*mask2 + 1i*diff_Im_FTOxOy.map(:,:,k).*mask2;
    end
    dff_DW_amp_Q1 = fourier_transform2d(diff_FTOxOy_Q1,'none','amplitude','ift'); 
    dff_DW_amp_Q2 = fourier_transform2d(diff_FTOxOy_Q2,'none','amplitude','ift'); 
    dff_DW_amp = dff_DW_amp_Q1;
    dff_DW_amp.map = dff_DW_amp_Q1.map + dff_DW_amp_Q2.map;
    %img_obj_viewer2(dff_DW_amp_Q1);
    %img_obj_viewer2(dff_DW_amp_Q2);
    img_obj_viewer2(dff_DW_amp);
end