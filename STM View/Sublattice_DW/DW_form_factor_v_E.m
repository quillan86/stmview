function Form_Factor = DW_form_factor_v_E(q_px,filt_w,data)

[sum_Re_FTOxOy sum_Im_FTOxOy diff_Re_FTOxOy diff_Im_FTOxOy] = BSCCO_OxOy_sum_diff_map(data,0);
%     img_plot2((diff_Im_FTOxOy.map(:,:,1).^2 + diff_Im_FTOxOy.map(:,:,1).^2));
%     colormap(cols);
%     caxis([-3000 3000]);
%     zoom(4);
    [nr nc nz] = size(data.map);
    mask1 = Gaussian2D(1:nr,1:nc,filt_w,filt_w,0,[q_px(1,1) q_px(2,1)],1);
    mask2 = Gaussian2D(1:nr,1:nc,filt_w,filt_w,0,[q_px(1,2) q_px(2,2)],1);
    mask = mask1 + mask2;      
    %img_plot2(mask);
    %zoom(4);        
    
    sum_v_E = zeros(nz,1);
    diff_v_E = zeros(nz,1);
    
    for i = 1:nz
        sum_tmp = sum_Re_FTOxOy.map(:,:,i).^2 + sum_Im_FTOxOy.map(:,:,i).^2;
        diff_tmp = diff_Re_FTOxOy.map(:,:,i).^2 + diff_Im_FTOxOy.map(:,:,i).^2;        
        sum_v_E(i) = sum(sum(mask.*sum_tmp));
        diff_v_E(i) = sum(sum(mask.*diff_tmp));
    end
    figure; plot(sum_v_E)
    figure; plot(diff_v_E)
    
    Form_Factor.sum = sum_v_E;
    Form_Factor.diff = diff_v_E;
    Form_Factor.e = sum_Re_FTOxOy.e;
    Form_Factor.q = q_px;
    Form_Factor.width = filt_w;
    assignin('base','FormFactor',Form_Factor);
end