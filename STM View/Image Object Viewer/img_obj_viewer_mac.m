function h = img_obj_viewer_mac(in_data)

%  Create and then hide the GUI as it is being constructed.

f = figure('NumberTitle', 'off',...                            
              'Position',[150,150,355,393],...
              'Color',[0.5 0.5 0.5],...
              'MenuBar', 'none',...
              'WindowButtonMotionFcn',@get_axes_pos,...
              'Pointer','crosshair',...
              'Renderer','zbuffer',...
              'Visible','off',...
              'CloseRequestFcn',@img_obj_closereq);
% make a copy of in_data in guidata - copy by reference invoked so only one copy
% of object data exists in guidata
guidata(f,in_data);
[nr, nc, nz] = size(getfield(guidata(f),'map'));

obj_name = getfield(guidata(f),'name');
obj_var = getfield(guidata(f),'var');
obj_energy = getfield(guidata(f),'e');

set(f,'Name',[obj_name '-' obj_var]);

coord_tb = uicontrol('Style','text',...                
                'Position',[100,5,250,35],...
                'UserData',[0 0]);

   str={['crd: ' '( ' num2str(0, '%6.4f') ','  num2str(0,'%6.4f') ' )',...
       '   ' 'r: ' num2str(0,'%6.4f'),...
   '   ' 'pxl: ' '( ' num2str(0,'%6.0f') ',' num2str(0,'%6.0f') ' )' ],...
   ['z: ' '( ' num2str(0, '%6.5f') ' )']};
   set(coord_tb,'String',str);
            
   bias = uicontrol('Style','text',...
                     'String','Bias (V)',...
                     'Position',[10,27,65,12]);
                 
  %check to see if data set has sweep parameter Bias or Z and adjust bias
  %string accordingly
  if isfield(in_data.info,'sweep_signal')
      set(bias,'String',in_data.info.sweep_signal);
  end
                 
   energy_list = uicontrol('Style','popupmenu',...       
          'String', num2str(obj_energy','%10.2f'),...
          'Value', 1,...
          'Position',[1,7,85,14],...
          'Callback',{@plot_Callback},'String', num2str(1*obj_energy','%10.4f'));
         %'String', num2str(1000*data.e','%10.2f'),...
   energy_slider = uicontrol('Style','slider',...
          'Value',1,...
          'Min',1,'Max',nz,...
          'SliderStep',[1/nz 10/nz],...
          'Position',[87,2,10,37],...
          'Callback',{@slider_Callback});
% slider visibility set by number of layers
if nz == 1
    slide_switch = 'off';
else
    slide_switch = 'on';
end   
set(energy_slider,'Visible',slide_switch);
   ha = axes('Units','Pixels','Position',[2,42,352,352]);  
   %align([bias, energy_list],'Center','None');   
   
   % allow zoom function for figure;
   zh = zoom(f); set(zh,'Enable','off');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Menu Bar%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
f0 = uimenu('Label','Save');
    f0a = uimenu(f0,'Label','Put on Workspace','Callback',@wrk_spc_Callback);
    f0b = uimenu(f0,'Label','Save Layer to Workspace','Callback',@save_lyr_Callback);
          uimenu(f0,'Label','Save Zoomed Layer to Workspace','Callback',@save_zm_lyr_Callback);
          uimenu(f0,'Label','Export Movie','Callback',@export_movie_Callback);
          uimenu(f0,'Label','Export Multipanel Panel Movie','Callback',@export_movie_multipanel_Callback);

disp = uimenu('Label','Display');
    uimenu(disp,'Label','Select Palette','Callback',@sel_pal_Callback);
    uimenu(disp,'Label','Plot Color Bar','Callback',@plot_colorbar_Callback);
    uimenu(disp,'Label','Save Layer Histogram Limits to Workspace','Callback',@save_hist_lyr_Callback);
    uimenu(disp,'Label','Adjust Histogram','Callback',@histogram_Callback);
    uimenu(disp,'Label','Invert Color Scale','Callback',@invert_color_Callback);

spect_view = uimenu(disp,'Label','View Spectra');
    f1a = uimenu(spect_view,'Label','Spectrum Viewer','Callback',@spect_viewer_Callback);
    %uimenu(spect_view,'Label','Spectrum Viewer + Fano',
    uimenu(spect_view,'Label','Show Average Spectrum','Callback',@avg_spect_Callback);
    uimenu(spect_view,'Label','Show Average Spectrum + Variance','Callback',@avg_spect_var_Callback);
    
    uimenu(disp,'Label','Show Data Structure Fields','Callback',@disp_data_Callback);

process = uimenu('Label','Process');
    avg_menu = uimenu(process,'Label','Averaging');
        uimenu(avg_menu,'Label','Energy box-car average','Callback',@boxcar_avg_Callback);
        uimenu(avg_menu,'Label','4 pixel average','Callback',@px4_avg_Callback);

    crop_menu = uimenu(process,'Label','Crop');
        uimenu(crop_menu,'Label','Crop by Coordinates', 'Callback',@crop_Callback)
        uimenu(crop_menu,'Label','Crop Current FOV', 'Callback',@crop_FOV_Callback)
        uimenu(crop_menu,'Label','Cross Along z-direction','Callback',@crop_z_Callback)
    
    uimenu(process,'Label','Change Pixel Dimension','Callback',@pix_dim_Callback);
    uimenu(process,'Label','Rotate Map','Callback',@rot_map_Callback);
    uimenu(process,'Label','Line Cut','Callback',@line_cut_Callback);
    uimenu(process,'Label','Polar Map Section Avg','Callback',@polar_avg_Callback);
    
    f2a = uimenu(process,'Label','Background Subtraction');
        uimenu(f2a,'Label','0','Callback',{@bkgnd_Callback,0});
        uimenu(f2a,'Label','1','Callback',{@bkgnd_Callback,1});
        uimenu(f2a,'Label','2','Callback',{@bkgnd_Callback,2});
        uimenu(f2a,'Label','3','Callback',{@bkgnd_Callback,3});
        uimenu(f2a,'Label','4','Callback',{@bkgnd_Callback,4});
        uimenu(f2a,'Label','5','Callback',{@bkgnd_Callback,5});
        uimenu(f2a,'Label','6','Callback',{@bkgnd_Callback,6});
        
    uimenu(process,'Label','Line Subtraction','Callback',@LineSubt_Callback);
        
    filt_menu = uimenu(process,'Label','Filtering');
        uimenu(filt_menu,'Label','Bilateral Filter','Callback',@bilat_filt_Callback);
        uimenu(filt_menu,'Label','Triateral Filter I','Callback',@trilat_filt1_Callback);
        uimenu(filt_menu,'Label','Gaussian Filter','Callback',@gauss_filt_Callback); 
        uimenu(filt_menu,'Label','Low-Pass Fourier Filter','Callback',@low_pass_fourier_filter_Callback);
    math_menu = uimenu(process,'Label','Math');
        uimenu(math_menu,'Label', 'Add/Subtract');
        uimenu(math_menu,'Label', 'Multiply/Divide');
        uimenu(math_menu,'Label', 'Add/Subtract');
        uimenu(math_menu,'Label', 'Map^N','Callback',@map_squared_Callback);
        uimenu(math_menu,'Label','d/dE','Callback',@deriv_Callback);
        uimenu(math_menu,'Label','d/dx','Callback',@map_deriv_x_Callback);
        uimenu(math_menu,'Label','d/dy','Callback',@map_deriv_y_Callback);
        uimenu(math_menu,'Label','Laplacian','Callback',@map_Laplacian_Callback);
        uimenu(math_menu,'Label','Integral Map','Callback',@map_integrate_Callback);
    pixel_fix_menu = uimenu(process,'Label','Fix Pixels');
        uimenu(pixel_fix_menu,'Label','AutoFix with STD','Callback',@auto_fix_pxl_Callback);
    img_manip_menu = uimenu(process,'Label','Image Manipulation');
        uimenu(img_manip_menu,'Label','Apply Custom Transform','Callback',@custom_transf_Callback);
        uimenu(img_manip_menu,'Label','Shear Correct','Callback',@shear_cor_Callback);
        uimenu(img_manip_menu,'Label','Symmetrize','Callback',@sym_Callback);
        uimenu(img_manip_menu,'Label','(x,y) Gaussian Blur','Callback',@blur_Callback);
        uimenu(img_manip_menu,'Label','Remove FT Center','Callback',@rm_center_Callback);        
     LF_menu = uimenu(process,'Label','LF Correct');
        uimenu(LF_menu,'Label','Generate Phase Map','Callback',@LF_phase_gen_Callback);
        uimenu(LF_menu,'Label','Apply tx,ty correction','Callback',@LF_correct_apply_Callback);
    
    f2d = uimenu(process,'Label','Inter-Data Math Operations','Callback',@intdata_ops_Callback);
        
    register_menu = uimenu(process,'Label','Image Cross Registration');
        uimenu(register_menu,'Label','Global Register','Callback',@register_Callback);
        uimenu(register_menu,'Label','Local Register','Callback',@local_register_Callback);
       
    f2e = uimenu(process,'Label','Copy Data from...');
        uimenu(f2e,'Label','GUI Object','Callback',@copy_gui_data_Callback);
        uimenu(f2e,'Label','Workspace','Callback',@copy_wrkspc_data_Callback);              
        uimenu(process,'Label','Extract Layer','Callback',@extract_lyr_Callback);
    
    

analysis = uimenu('Label','Analysis');
    pk_fit = uimenu(analysis,'Label','Peak Fit Tools');
        uimenu(pk_fit,'Label','2D Gaussian Peak Fit','Callback',@peak_fit2D_Gauss_Callback);
        
    cntr_mass = uimenu(analysis,'Label','Center of Mass','Callback',@center_of_mass_Callback);
    histogram = uimenu(analysis,'Label','2D Histograms','Callback',@hist2d_Callback);
    ft_anal = uimenu(analysis,'Label','Fourier Transform','Callback',@ft_Callback);       
    
    uimenu(analysis,'Label','Convert to Polar Coord','Callback',@polar_conv_Callback);
    
    cor_anal = uimenu(analysis,'Label','Correlations');       
        uimenu(cor_anal,'Label','Autocorrelation','Callback',@autocor_Callback)
        uimenu(cor_anal,'Label','Cross Correlation','Callback',@crosscorr_Callback)
    
        zmap = uimenu(analysis,'Label','Z-Map','Callback',@zmap_Callback);
    
      
    bscco_anal = uimenu(analysis,'Label','BSCCO');
        uimenu(bscco_anal,'Label','Gap Map','Callback',@gapmap_Callback);
        uimenu(bscco_anal,'Label','Dip Map','Callback',@BSCCO_dip_map_Callback);        
        uimenu(bscco_anal,'Label','Omega Map','Callback',@omega_Callback);
        uimenu(bscco_anal,'Label','Rescale energy by gap','Callback',@gap_scale_Callback)
        uimenu(bscco_anal,'Label','Gap Sorted Spectra','Callback',@gap_sort_Callback);
        uimenu(bscco_anal,'Label','SM Phase Extraction','Callback',@SM_phase_Callback);
        uimenu(bscco_anal,'Label','SM Phase Averaged Map Values','Callback',@SM_phase_avg_val);
        uimenu(bscco_anal,'Label','Cu Ox Oy atomic position','Callback',{@cuprate_atomic_site_gen_Callback,0});
        uimenu(bscco_anal,'Label','Cu Ox Oy index from atomic position','Callback',{@cuprate_atomic_site_gen_Callback,1});
        
        bscco_dw_anal = uimenu(bscco_anal,'Label','Sublattice & DW');
            uimenu(bscco_dw_anal,'Label','Generate Cu, Ox & Oy Map','Callback',@sublattice_maps_Callback);
            uimenu(bscco_dw_anal,'Label','Generate Ox+Oy,Ox-Oy','Callback',@OxOy_sum_diff_maps_Callback);
            uimenu(bscco_dw_anal,'Label','Generate FT of Ox+Oy,Ox-Oy','Callback',@OxOy_sum_diff_FT_maps_Callback);
            uimenu(bscco_dw_anal,'Label','Generate PSD of Ox+Oy, Ox-Oy','Callback',@OxOy_sum_diff_PSD_Callback);
            uimenu(bscco_dw_anal,'Label','DW form factor vs E','Callback',@form_factor_v_E_Callback);
            uimenu(bscco_dw_anal,'Label','DW form factor r-space amplitude','Callback', @DW_amplitude_Callback);
            uimenu(bscco_dw_anal,'Label','DW form factor r-space directionality','Callback',@DW_directional_Callback);
            
    URS_anal = uimenu(analysis,'Label','URu2Si2');
        uimenu(URS_anal,'Label','Fano Map');
        uimenu(URS_anal,'Label','Generate Si U index','Callback',@URS_atomic_site_gen_Callback);
            
    nem_anal = uimenu(analysis,'Label','Nematicity Analysis');    
        uimenu(nem_anal,'Label','MNR(r) - r-space Derived','Callback',@MNR_Callback);
        uimenu(nem_anal,'Label','MNQ(r) - k-space Derived','Callback',@MNQ_Callback);
        uimenu(nem_anal,'Label','MNQ(E)','Callback',@MNQ_E_Callback);
        uimenu(nem_anal,'Label','Nematic Tile 1','Callback',@nematic_tile1_Callback);
        uimenu(nem_anal,'Label','Nematic Tile 2','Callback',@nematic_tile2_Callback);
        uimenu(nem_anal,'Label','Nematic Domain Mean Subtraction','Callback',@nem_mean_subt_Callback);
        uimenu(nem_anal,'Label','Binary View of Domains','Callback',@binary_domains_Callback);
        uimenu(nem_anal,'Label','Average Domain Spectra','Callback',@avg_nem_spect_Callback);
f4 = uimenu('Label','Zoom OFF','Callback',@zoom_Callback);


%%%%%%%%%%%%%%%%%%%%%%%%%% Initialize the GUI%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Change units to normalized so components resize automatically.
set([f,ha],'Units','normalized');
data_main = guidata(f);
% generate a histogram for each layer of data.  Will be used for setting
% color axis limit.  Also include the dimensions of img_obj.
n = 1000;
for k = 1:nz
    tmp_layer = reshape(data_main.map(:,:,k),nr*nc,1);
    tmp_std = std(tmp_layer);
    % pick a common number of bins based on the largest spread of values in
    % one of the layers
    n1 = abs((max(tmp_layer) - min(tmp_layer)))/(2*tmp_std)*1000;
    n = max(n,floor(n1));    
end
clear tmp_layer n1 tmp_std

for k=1:nz
    [histo.freq(k,1:n) histo.val(k,1:n)] = hist(reshape(data_main.map(:,:,k),nr*nc,1),n);
end
histo.size = [nr nc nz];

%get the initial color map

color_map = get_color_map('Blue2');
%initialize color limit values for each layer in caxis
caxis_val = zeros(nz,2);
for k=1:nz;
      caxis_val(k,1) = min(histo.val(k,:)); % min value for each layer
      if isnan(caxis_val(k,1))
          caxis_val(k,1) = 0;
      end
      caxis_val(k,2) = max(histo.val(k,:)); % max value for each layer
      if isnan(caxis_val(k,2))
          caxis_val(k,2) = 0;
      end
end
%update the UserData in the figure object to store caxis information
set(f,'UserData',caxis_val);

%Create a plot in the axes.
imagesc((data_main.map(:,:,1)));
set(ha,'XLim',[1 nc]); set(ha,'YLim',[1 nr]);
%imagesc_normal((data.map(:,:,1)));

colormap(color_map); axis off; axis equal; shading flat;
caxis([caxis_val(1,1) caxis_val(1,2)])
clear data;
% Move the GUI to the center of the screen.
%movegui(f,'center')

% Make the GUI visible.
set(f,'Visible','on');
%set(ha, 'NextPlot', 'replace');
%%%%%%%%%%%%%%%%%%%%%%%CALLBACK FUNCTIONS%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    function plot_Callback(hObject,eventdata)
       data = guidata(f);      
       layer=get(energy_list,'Value'); 
       set(energy_slider,'Value',layer);
       color_lim = get(f,'UserData');
       color_lim = color_lim(layer,:);
       x_lim = get(ha,'XLim');
       y_lim = get(ha,'YLim');  
       imagesc((data.map(:,:,layer))); 
       zoom reset;
       axis off; axis equal; shading flat;
       set(ha,'XLim',x_lim); set(ha,'YLim',y_lim);       
       caxis(color_lim);
    end
    function slider_Callback(hObject,eventdata)
        data = guidata(f);
        layer = round(get(energy_slider,'Value'));
        set(energy_list,'Value',layer);
        set(energy_slider,'Value',layer);
        color_lim = get(f,'UserData');
        color_lim = color_lim(layer,:);
        x_lim = get(ha,'XLim');
        y_lim = get(ha,'YLim');
        
        imagesc((data.map(:,:,layer)));
        zoom reset;
         set(ha,'XLim',x_lim); set(ha,'YLim',y_lim);         
        axis off; axis equal; shading flat;
        %[nr, nc, nz] = size(data.map);
        %set(ha,'XLim',[1 nc]); set(ha,'YLim',[1 nr]);
       
        caxis(color_lim);
    end

    function get_axes_pos(src,evnt)
        data = guidata(f);
        n = get(energy_list,'Value');
        cp = get(ha,'CurrentPoint');
        xinit = round(cp(1,1));yinit = round(cp(1,2));
        if xinit > nc || yinit > nr || xinit < 1 || yinit < 1
           return;
        end
        str={['crd: ' '( ' num2str(data.r(xinit), '%6.4f') ','  num2str(data.r(yinit),'%6.4f') ' )',...
             '   ' 'r: ' num2str(sqrt(data.r(xinit)^2 + data.r(yinit)^2),'%6.4f'),...
         '   ' 'pxl: ' '( ' num2str(xinit,'%6.0f') ',' num2str(yinit,'%6.0f') ' )' ],...
        ['z: ' '( ' num2str(data.map(yinit,xinit,n), '%6.5f') ' )']};
        set(coord_tb,'String',str);
        set(coord_tb,'UserData',[xinit yinit]); 
        spect_viewer_handle = get(f1a,'UserData');
        if ~isempty(spect_viewer_handle)
            axes(spect_viewer_handle);
            plot(data.e,squeeze(squeeze(data.map(yinit,xinit,:))));
            xlim([min(data.e) max(data.e)]);
        end            
    end
    function zoom_Callback(hObject,eventdata)        
        if strcmp(get(f4,'Label'),'Zoom OFF')
            set(zh,'Enable','on');
            set(f4,'Label','Zoom ON')
        else
            set(zh,'Enable','off');
            set(f4,'Label','Zoom OFF')
        end
    end
    function histogram_Callback(hObject,evendata)
        layer=get(energy_list,'Value'); 
        %lyr_lin = reshape(data.map(:,:,layer),nr*nc,1);
        data_histogram_dialogue(layer,histo,f,ha);
    end

    function sel_pal_Callback(hObject,eventdata)
        col_map = get(f,'Colormap');
        %palette_sel_dialogue(f,color_map);        
        palette_sel_dialogue(f,col_map);        
    end
    function plot_colorbar_Callback(hObject,eventdata)
         col_map = get(f,'Colormap');
         x = linspace(0,1,300);
        for i = 1:50
            palette(1:300,i) = x;
        end
        figure('Position',[150,150,180,300],'NumberTitle', 'off');
        pcolor(palette); shading flat; axis off; axis equal;colormap(col_map);
    end

    function save_hist_lyr_Callback(hobject,eventdata)
        color_lim = get(f,'UserData'); 
        data = guidata(f);
        default_name = ['obj_' data.name '_' data.var];
        answer = wrk_space_dialogue(default_name);
        if ~isempty(answer)
            assignin('base',answer{1},color_lim)
        end
        
    end
    function invert_color_Callback(hObject,eventdata)
        c_map = get(f,'Colormap');
        inv_cmap = c_map(end:-1:1,:);
        set(f,'Colormap',inv_cmap);
    end
    function spect_viewer_Callback(hObject,eventdata)
        spect_viewer_handle = spectrum_viewer(f1a);
        set(f1a,'UserData',spect_viewer_handle);
    end
    
    function avg_spect_Callback(hObject,eventdata)
        data = guidata(f);
        x = data.e*1000;
        if ~isempty(data.ave)
            y = data.ave;            
        else
            y = squeeze(mean(mean(data.map)));
        end
            graph_plot(x,y,'b',[data.name ' Average Spectrum']);
    end
    
    function avg_spect_var_Callback(hObject,eventdata)
        data = guidata(f);
        plot_spectrum_var(data,'b',[data.name ' Average Spectrum + Variance']);
    end
    
    function disp_data_Callback(hObject,eventdata)
        guidata(f)
    end

    function wrk_spc_Callback(hObject,eventdata)
         data = guidata(f);
         default_name = ['obj_' data.name '_' data.var];
         answer = wrk_space_dialogue(default_name);
         if ~isempty(answer)
            assignin('base',answer{1},data)
        end
    end

    function save_lyr_Callback(hObject,eventdata)  
       data = guidata(f);
       layer=get(energy_list,'Value'); 
       prompt={'Workspace Variable Name'};
       name='Save Layer to Workspace';
       numlines=1;
       defaultanswer= {''};
       answer = inputdlg(prompt,name,numlines,defaultanswer);       
       if strcmp(answer{1},'')
           return;
       else
           assignin('base',answer{1},data.map(:,:,layer));
       end
    end

function save_zm_lyr_Callback(hObject,eventdata)  
       data = guidata(f);
       layer=get(energy_list,'Value');
       prompt={'Workspace Variable Name'};
       name='Save Zoomed Layer to Workspace';
       numlines=1;
       defaultanswer= {''};
       answer = inputdlg(prompt,name,numlines,defaultanswer);       
       if strcmp(answer{1},'')
           return;
       else
           xlimits = round(get(gca,'xlim'));          
           ylimits = round(get(gca,'ylim')); 
           xlimits = xlimits(1):xlimits(end);  
           ylimits = ylimits(1):ylimits(1)+length(xlimits)-1; %make sure it's square
           assignin('base',answer{1},data.map(ylimits,xlimits,layer));
       end
    end

    function export_movie_Callback(hObject,eventdata)
        data = guidata(f);
        color_lim = get(f,'UserData');
       %color_lim = color_lim(layer,:);             
       c_map =  get(f,'Colormap');
        exp_movie_dialogue(data.map,data.e,data.r,data.r,c_map,color_lim);
    end

    function export_movie_multipanel_Callback(hObject,eventdata)
        exp_movie_multipanel_dialogue;
    end

    function bilat_filt_Callback(hObject,eventdata)
        bilateral_filt_dialogue(guidata(f));
    end
    function trilat_filt1_Callback(hObject,eventdata)
        trilateral_filt_dialogue(guidata(f));
    end

    function gauss_filt_Callback(hObject,eventdata)
        data = guidata(f);
        gauss_filter_dialogue(data);
    end

    function low_pass_fourier_filter_Callback(hObject,eventdata)
        data = guidata(f);
        f_filter_low_pass(data);
    end

    function crop_Callback(hOjbect,eventdata)
        data = guidata(f);
        crop_dialogue(data);
    end
    function crop_FOV_Callback(hOjbect,eventdata)
        xlimits = round(get(gca,'xlim'));          
        ylimits = round(get(gca,'ylim'));            
        ylimits(2) = ylimits(1) + abs(xlimits(1)-xlimits(2)); %make sure it's square
        data = guidata(f);
        crop_dialogue(data,xlimits,ylimits);
    end

    function crop_z_Callback(hObject,eventdata)
        crop_map_in_energy_dialogue(guidata(f));
    end

    function rot_map_Callback(hObject,eventdata)
        map_rotate_dialogue(guidata(f));
    end

    function pix_dim_Callback(hObject,eventdata)
        data = guidata(f);
        pix_dim_dialogue(data)
    end
    function line_cut_Callback(hObject,eventdata)
        data = guidata(f);
        line_cut_dialogue(data);
    end
    function bkgnd_Callback(hObject,eventdata,order)
        data = guidata(f);
       new_data = polyn_subtract(data,order);        
       IMG(new_data);
    end

    function LineSubt_Callback(hObject,eventdata)
        data = guidata(f);
        ord = 0;
        new_data = line_subt_map(data,ord);
        IMG(new_data);
        
    end

    function ft_Callback(hObject,eventdata)
        data = guidata(f);
        ft_dialogue(data);
    end

    function autocor_Callback(hObject,eventdata)     
        data = guidata(f);
        autocorr_dialogue(data);
    end

    function crosscorr_Callback(hObject,eventdata)
        corr_dialogue(f);
    end
    function zmap_Callback(hObject,eventdata)
        data = guidata(f);
        Zmaps(data);        
    end

    function polar_conv_Callback(hObject,eventdata)
        data = guidata(f);
        cartesian_to_polar(data);
    end

    function polar_avg_Callback(hObject,eventdata)
        prompt = {'Enter N, for 2pi/N section averaging'};
        dlg_title = 'Angular Average in Polar Polar';
        num_lines = 1;
        default_answer = {'1'};
        answer = inputdlg(prompt,dlg_title,num_lines,default_answer);    
        polar_symmetrize(data,str2double(answer));
    end

    function auto_fix_pxl_Callback(hObject,eventdata)        
        auto_fix_pixel_dialogue(guidata(f));
    end
    function custom_transf_Callback(hObject,eventdata)
        data = guidata(f);
        transf_map_dialogue(data);
    end
    function shear_cor_Callback(hObject,eventdata)
        data = guidata(f);
        shear_corr_dialogue(data);
    end
    function sym_Callback(hObject,eventdata)
        data = guidata(f);
        sym_map_dialogue(data);
    end
    function blur_Callback(hObject,eventdata)
        data = guidata(f);
        gauss_blur_dialogue(data);
    end
    function rm_center_Callback(hObject,eventdata)
        data = guidata(f);
        rm_center_dialogue(data);
    end
    
    function LF_phase_gen_Callback(hObject,eventdata)
        data = guidata(f);
        LF_phase_gen_dialogue(data);
    end

    function LF_correct_apply_Callback(hObject,eventdata)
        data = guidata(f);
        fvar = isfield(data,{'tx','ty'});
        if fvar(1)*fvar(2) == 0
            display('Non existant fields for LF Correction');
            return;
        else
            if ~isempty(data.tx)*~isempty(data.ty) == 1
                new_data = LF_correct_map_v2(data.tx,data.ty,data);
                IMG(new_data);
            else
                display('tx or tx is empty');
                return;
            end
        end
    end

    function register_Callback(hObject,eventdata)
        global_register(guidata(f));                
    end

    function local_register_Callback(hObject,eventdata)
        local_register(guidata(f));
    end


    function copy_gui_data_Callback(hObject,eventdata)        
        copy_gui_data_dialogue(f);                
    end
    function copy_wrkspc_data_Callback(hObject,eventdata);
        copy_wrkspc_data_dialogue(f);       
    end

    function intdata_ops_Callback(hObject,eventdata)
        intdata_ops_dialogue(f);
    end
    
    function map_squared_Callback(hObject,eventdata)
        data = guidata(f);
        prompt = {'Enter degree of power, N'};
        dlg_title = 'Elements of Map to Power N';
        num_lines = 1;
        default_answer = {'1'};
        answer = inputdlg(prompt,dlg_title,num_lines,default_answer);    
        map_to_power(data,str2double(answer));
    end
    function deriv_Callback(hObject,eventdata)        
        map_deriv_dialogue(guidata(f));
    end
    
    function map_deriv_x_Callback(hObject,eventdata)
        map_deriv(guidadta(f),1);
    end
    function map_deriv_y_Callback(hObject,eventdata)
        map_deriv(guidadta(f),2);
    end

    function map_Laplacian_Callback(hObject,eventdata)
        map_Laplacian(guidadta(f));        
    end

    function map_integrate_Callback(hObject,eventdata)
        map_integrate_dialogue(guidata(f));
    end
    function boxcar_avg_Callback(hObject,eventdata)       
        boxcar_avg_map_dialogue(guidata(f));
    end
    
    function px4_avg_Callback(hObject,eventdata)
        px4_avg(guidata(f));
    end

    function extract_lyr_Callback(hObject,eventdata)
       data = guidata(f);
       % open new window with just the specified layer
       layer=get(energy_list,'Value'); 
       color_lim = get(f,'UserData');
       color_lim = color_lim(layer,:);             
       c_map =  get(f,'Colormap');
       
       % select title for extracted image
       if length(data.e) <= 1
           str = ['Layer from ' data.name '-' data.var];
       else 
           str = ['Layer from ' data.name '-' data.var ' at ' num2str(data.e(layer)*1000) 'mV'];
       end
       img_plot2((data.map(:,:,layer)),c_map,str);               
       caxis(color_lim);              
    end
    
    function peak_fit2D_Gauss_Callback(hObject,eventdata)
        layer = get(energy_list,'Value');
        tmp = guidata(f);
        peak_fit2D_dialogue(tmp(:,:,layer));
    end

    function center_of_mass_Callback(hObject,eventdata)
        data = guidata(f);
        layer = get(energy_list,'Value');
        center_of_mass(squeeze(data.map(:,:,layer)));
    end
    function hist2d_Callback(hObject,eventdata)
        hist2d_dialogue(f);
    end
    function gapmap_Callback(hObject,eventdata)
        data = guidata(f);
        BSCCO_gap_map_dialogue(data);
    end
    
    function BSCCO_dip_map_Callback(hobject,eventdata)
        BSCCO_dip_map_dialogue(guidata(f),f);
    end

    function omega_Callback(hObject,eventdata)
        display('Omega Map');
    end
    function gap_scale_Callback(hObject,eventdata)
        data = guidata(f);
        if isfield(data,'gap_map')
            gap_scale_map(data,data.gap_map);
        else
            display('No gap map from which to generate scaling')
            return;
        end
    end
    function gap_sort_Callback(hObject,eventdata)
        display('yes');
    end

    function SM_phase_Callback(hObject,eventdata)
        SM_phase_dialogue(guidata(f),f);
    end

    function SM_phase_avg_val(hObject,eventdata)
        SM_phase_avg_val_dialogue(guidata(f),f);
    end

    function cuprate_atomic_site_gen_Callback(hObject,eventdata,opt)        
        data_loc = guidata(f);
        % opt variable allows generating either the full atomic positions
        % with index or just the index from already existing atomic
        % position matrices Cu,Ox,Oy.
        if opt == 0
            if ~isfield(data_loc,'phase_map')        
                display('No phase map information - Cannot proceed');
                return;
            end
        
        phase_map = data_loc.phase_map;
        data_loc.Cu =  atomic_pos(phase_map,0,0);
        data_loc.Ox =  atomic_pos(phase_map,pi,0);
        data_loc.Oy =  atomic_pos(phase_map,0,pi);
        guidata(f,data_loc);
        end
        if opt == 1
            if ~isfield(data_loc,'Cu')        
                display('No atomic position information - Cannot proceed');
                return;
            end
        end
        %[Cu_index Ox_index1 Ox_index2 Oy_index1 Oy_index2] = BSCCO_Cu_O_index(data_loc.Cu,data_loc.Ox,data_loc.Oy,data_loc.r);
        [Cu_index, Ox_index1, Ox_index2, Oy_index1, Oy_index2] = BSCCO_Cu_O_index(data_loc.Cu,data_loc.Ox,data_loc.Oy);
        data_loc.Cu_index = Cu_index;
        data_loc.Ox_index1 = Ox_index1; data_loc.Ox_index2 = Ox_index2; 
        data_loc.Oy_index1 = Oy_index1; data_loc.Oy_index2 = Oy_index2;
        guidata(f,data_loc);
        
    end

    function URS_atomic_site_gen_Callback(hObject,eventdata)
        data_loc = guidata(f);

        if ~isfield(data_loc,'phase_map')        
            display('No phase map information - Cannot proceed');
            return;
        end
        phase_map = data_loc.phase_map;
        data.loc.Si  = atomic_pos(phase_map,0,0);
    end

    function sublattice_maps_Callback(hObject,eventdata)
        [Ox_map Oy_map Cu_map] = BSCCO_sublattice_maps(guidata(f));
        IMG(Ox_map); 
        IMG(Oy_map); 
        IMG(Cu_map);
    end

    function OxOy_sum_diff_maps_Callback(hObject,eventdata)
        [~,~,~, ~,real_sum,real_diff] = BSCCO_OxOy_sum_diff_map_v2(guidata(f),2);
        IMG(real_sum);
        IMG(real_diff);
    end

    function OxOy_sum_diff_FT_maps_Callback(hObject,eventdata)
        %load RedWhiteBlue
        %cols = RedWhiteBlue;
        [sum_Re_FTOxOy, sum_Im_FTOxOy, diff_Re_FTOxOy, diff_Im_FTOxOy] = BSCCO_OxOy_sum_diff_map(guidata(f),0);
        IMG(sum_Re_FTOxOy);
        %colormap(cols);
        IMG(sum_Im_FTOxOy);
        %colormap(cols);
        IMG(diff_Re_FTOxOy);
        %colormap(cols);
        IMG(diff_Im_FTOxOy);
        %colormap(cols);
    end

    function OxOy_sum_diff_PSD_Callback(hObject,eventdata)
        [~,~,~, ~,psd_sum,psd_diff] = BSCCO_OxOy_sum_diff_map_v2(guidata(f),1);
        IMG(psd_sum);
        IMG(psd_diff);
        
    end

    function form_factor_v_E_Callback(hObject,eventdata)
        DW_form_factor_v_E_dialogue(guidata(f))
    end

    function DW_amplitude_Callback(hObject,eventdata)
        DW_amplitude_dialogue(guidata(f));       
    end

    function DW_directional_Callback(hObject,eventdata)
        DW_directional_dialogue(guidata(f));
    end

    function MNR_Callback(hObject,eventdata)
        data = guidata(f);
        MNR_dialogue(data);
    end
    function MNQ_Callback(hObject,eventdata)
        data = guidata(f);
        MNQ_dialogue(data);
    end
    function MNQ_E_Callback(hObject,eventdata)
        data = guidata(f);
        MNQ_E_dialogue(data);
    end
    function avg_nem_spect_Callback(hObject,eventdata)
        data = guidata(f);
        avg_nem_spect_dialogue(data);
    end
    function nematic_tile1_Callback(hObject,eventdata)
        data = guidata(f);
        nematic_tile_dialogue(data);
    end
    function nematic_tile2_Callback(hObject,eventdata)
        data = guidata(f);
        nematic_tile2(data);
    end
    function nem_mean_subt_Callback(hObject,eventdata)
        data = guidata(f);
        nem_dom_mean_subt(data);
    end
    function binary_domains_Callback(hObject,eventdata)
        data = guidata(f);
        binary_domains(data);
    end
        
end
function obj_gui = find_obj_gui(f)
% find all open figures
h = evalin('base','findobj(''type'',''figure'')');
% separate out all ones which have a structure element in their guidata
count = 0;
obj_gui = [];
for i = 1:length(h)
    if isstruct(guidata(h(i))) && h(i) ~= f
        count = count + 1;
        obj_gui(count) = h(i);     
    end
end

end
function img_obj_closereq(src,evnt)
   % User-defined close request function 
   % to display a question dialog box 
      selection = questdlg('Close This Figure?',...
         'Close Request Function',...
         'Yes','No','Yes'); 
      switch selection, 
         case 'Yes',
            delete(gcf)    
         case 'No'      
         return 
      end
   end