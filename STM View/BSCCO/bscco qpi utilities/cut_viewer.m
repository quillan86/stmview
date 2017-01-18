function h = cut_viewer(in_data)

f = figure('NumberTitle', 'off',...                            
              'Position',[150,150,1000,420],...
              'MenuBar', 'none',...
              'Pointer','crosshair',...
              'Renderer','zbuffer',...
              'Visible','on');

set(f,'Name','Cut Viewer');
ha = axes('Units','Pixels','Position',[50,42,352,352],'YLim',[0 100]);
hb = axes('Units','Pixels','Position',[500,300,352,100]);  
hc= axes('Units','Pixels','Position',[500,225,80,25],'Color','None');
hd= axes('Units','Pixels','Position',[600,225,80,25],'Color','None');
he= axes('Units','Pixels','Position',[700,225,80,25],'Color','None');
hf= axes('Units','Pixels','Position',[800,125,80,25],'Color','None');
hg= axes('Units','Pixels','Position',[900,125,80,25],'Color','None');


if ~isfield(in_data,'params')   
    in_data.params=cell(size(in_data.e));
end

guidata(f,in_data);

[nr,nz] = size(getfield(guidata(f),'cut'));
obj_energy = getfield(guidata(f),'e');
obj_r = getfield(guidata(f),'r');

energy_list = uicontrol('Style','popupmenu',...       
          'String', num2str(1000*obj_energy','%10.2f'),...
          'Value', 1,...
          'Position',[500,250,100,25],...
          'Callback',{@energy_list_Callback});

energy_slider = uicontrol('Style','slider',...
          'Value',1,...
          'Min',1,'Max',nz,...
          'SliderStep',[1/nz 10/nz],...
          'Position',[600,250,80,25],...
          'Callback',{@slider_Callback});

text_a = uicontrol('Style','edit',...       
  'String', '145',...
  'Position',[500,200,80,25]);

text_b = uicontrol('Style','edit',...       
'String', '3',...
'Position',[600,200,80,25]);

text_c = uicontrol('Style','edit',...       
'String', '15',...
'Position',[700,200,80,25]);

text_d = uicontrol('Style','edit',...       
  'String', '0.0625',...
  'Position',[500,150,80,25]);
          
text_e = uicontrol('Style','edit',...       
'String', '0.477',...
'Position',[600,150,80,25]);


text_f = uicontrol('Style','edit',...       
'String', '0.025',...
'Position',[700,150,80,25]);

text_g = uicontrol('Style','edit',...       
  'String', '0.0625',...
  'Position',[500,100,80,25]);
          
text_h = uicontrol('Style','edit',...       
'String', '0.477',...
'Position',[600,100,80,25]);


text_l = uicontrol('Style','edit',...       
'String', '0.025',...
'Position',[700,100,80,25]);

x_low_disp = uicontrol('Style','edit',...       
'String', '0',...
'Position',[40,5,30,20]);

x_high_disp = uicontrol('Style','edit',...       
'String', '1',...
'Position',[402,5,30,20]);


x_low = uicontrol('Style','edit',...       
'String', '0',...
'Position',[800,100,80,25]);

x_high = uicontrol('Style','edit',...       
'String', '1',...
'Position',[900,100,80,25]);


text_m = uicontrol('Style','edit',...       
'String', '0.0625',...
'Position',[500,50,80,25]);


text_n = uicontrol('Style','edit',...       
'String', '1',...
'Position',[600,50,80,25]);


text_o = uicontrol('Style','edit',...       
'String', '0.025',...
'Position',[700,50,80,25]);


fit_button=uicontrol('Style','pushbutton',...       
          'String', 'Fit',...
          'Position',[500,10,80,25],...
          'Callback',{@Fit_Callback});
      
fit_type=uicontrol('Style','popupmenu',...       
          'String', ['1 Peak'; '2 Peak' ;'3 Peak'],...
          'Position',[600,10,80,25],'Callback',{@fit_type_Callback});      

      
save_button=uicontrol('Style','pushbutton',...       
          'String', 'Save',...
          'Position',[700,10,80,25],...
          'Callback',{@Save_Callback});     
      
dont_bother=uicontrol('Style','checkbox',...       
          'String', 'Fit?',...
          'Position',[800,10,80,25],...
          'Value',1);       
      
test_button=uicontrol('Style','pushbutton',...       
          'String', 'Test',...
          'Position',[800,50,80,25],...
          'Callback',{@Test_Callback});   
      
export_button=uicontrol('Style','pushbutton',...
            'String', 'Export',...
            'Position',[900,50,80,25],...
          'Callback',{@Export_Callback});

      
set([f,ha,hb,hc,hd,he,hf,hg],'Units','normalized');
set([text_a,text_b,text_c,text_d,text_e,text_f,text_g,text_h,text_m,text_n,text_o,text_l,x_low,x_high,fit_button,fit_type,save_button,dont_bother,energy_list,test_button,x_low_disp,x_high_disp,export_button], 'Units', 'normalized');
      axes(hb)
      
set([text_g,text_h,text_m,text_n,text_o,text_l],'Enable','off')

imagesc(in_data.r,in_data.e.*1000,flipud(in_data.cut'));
colormap(gray);
axis off


axes(hc)
axis off
text_a_label = text(0.45,0.5,'a','FontSize',12);  

axes(hd)
axis off
text_b_label = text(0.45,0.5,'b','FontSize',12); 

axes(he)
axis off
text_c_label = text(0.45,0.5,'c','FontSize',12); 

axes(hf)
axis off
text_c_label = text(0.2,0.5,'Min q','FontSize',12); 

axes(hg)
axis off
text_c_label = text(0.2,0.5,'Max q','FontSize',12); 
      
%%%% callbacks
    function slider_Callback(hObject,eventdata)
        data = guidata(f);
        layer = round(get(energy_slider,'Value'));
        layer
        set(energy_list,'Value',layer);
        set(energy_slider,'Value',layer);
        energy_list_Callback;
    end
    function energy_list_Callback(hObject,eventdata)
        data = guidata(f);
        layer=get(energy_list,'Value');
        set(energy_slider,'Value',layer);
        if isempty(data.params{layer})==0
            
            f_type=1;%data.params{layer}.fit_type;
            a=data.params{layer}.a;
            fit_or_not=data.params{layer}.fit_or_not;
            
            if fit_or_not==1
                set(dont_bother,'Value',1);    
            else
                set(dont_bother,'Value',0);    
            end
            
            set(x_low,'String',num2str(data.params{layer}.lower));
            set(x_high,'String',num2str(data.params{layer}.higher));
            
            switch f_type
                
                case 1
                    set([text_g,text_h,text_m,text_n,text_o,text_l],'Enable','off')
                    set([text_a,text_b,text_c,text_d,text_e,text_f],'Enable','on')
                    set(text_a,'String',num2str(a(1)));
                    set(text_b,'String',num2str(a(2)));
                    set(text_c,'String',num2str(a(3)));
                    set(text_d,'String',num2str(a(4)));
                    set(text_e,'String',num2str(a(5)));
                    set(text_f,'String',num2str(a(6)));
                    set(fit_type,'Value',1);
   
                case 2
                    set([text_n,text_o,text_m],'Enable','off')
                    set([text_a,text_b,text_c,text_d,text_e,text_f,text_g,text_h,text_l],'Enable','on')
                    set(text_a,'String',num2str(a(1)));
                    set(text_b,'String',num2str(a(2)));
                    set(text_c,'String',num2str(a(3)));
                    set(text_d,'String',num2str(a(4)));
                    set(text_e,'String',num2str(a(5)));
                    set(text_f,'String',num2str(a(6)));
                    set(text_g,'String',num2str(a(7)));
                    set(text_h,'String',num2str(a(8)));
                    set(text_l,'String',num2str(a(9)));
                    set(fit_type,'Value',2);
                    
                case 3
                    set([text_a,text_b,text_c,text_d,text_e,text_f,text_g,text_h,text_m,text_n,text_o,text_l],'Enable','on')
                    set(text_a,'String',num2str(a(1)));
                    set(text_b,'String',num2str(a(2)));
                    set(text_c,'String',num2str(a(3)));
                    set(text_d,'String',num2str(a(4)));
                    set(text_e,'String',num2str(a(5)));
                    set(text_f,'String',num2str(a(6)));
                    set(text_g,'String',num2str(a(7)));
                    set(text_h,'String',num2str(a(8)));
                    set(text_l,'String',num2str(a(9)));
                    set(text_m,'String',num2str(a(10)));
                    set(text_n,'String',num2str(a(11)));
                    set(text_o,'String',num2str(a(12)));
                    set(fit_type,'Value',3);     
            end 
        end
        
        axes(ha)
        
        lower_disp=str2num(get(x_low_disp,'String'));
        higher_disp=str2num(get(x_high_disp,'String'));
        
        
        plot(data.r  ,data.cut(:,layer),'ok');
        xlim([lower_disp higher_disp]);
        
    end


    function fit_type_Callback(hObject,eventdata)
        
        type=get(fit_type,'Value');
        
        switch type
            
            case 1
                set([text_g,text_h,text_m,text_n,text_o,text_l],'Enable','off')
                set([text_a,text_b,text_c,text_d,text_e,text_f],'Enable','on')
                
                
            case 2
                set([text_n,text_o,text_m],'Enable','off')
                set([text_a,text_b,text_c,text_d,text_e,text_f,text_g,text_h,text_l],'Enable','on')
                
            case 3
                set([text_a,text_b,text_c,text_d,text_e,text_f,text_g,text_h,text_m,text_n,text_o,text_l],'Enable','on')
        end
    end


    function Test_Callback(hObject,eventdata)
        data = guidata(f);
        layer=get(energy_list,'Value');
        
        f_type=get(fit_type,'Value');

        lower=str2num(get(x_low,'String'));
        higher=str2num(get(x_high,'String'));
        lower_disp=str2num(get(x_low_disp,'String'));
        higher_disp=str2num(get(x_high_disp,'String'));

        switch f_type            
            case 1                
                
                a(1)=str2num(get(text_a,'String'));
                a(2)=str2num(get(text_b,'String'));
                a(3)=str2num(get(text_c,'String'));
                a(4)=str2num(get(text_d,'String'));
                a(5)=str2num(get(text_e,'String'));
                a(6)=str2num(get(text_f,'String'));
                
                vals=single_lorentzian_ebg(data,layer,lower,higher,lower_disp,higher_disp,a,f,ha,1);
 
            case 2
                
                a(1)=str2num(get(text_a,'String'));
                a(2)=str2num(get(text_b,'String'));
                a(3)=str2num(get(text_c,'String'));
                a(4)=str2num(get(text_d,'String'));
                a(5)=str2num(get(text_e,'String'));
                a(6)=str2num(get(text_f,'String'));
                a(7)=str2num(get(text_g,'String'));
                a(8)=str2num(get(text_h,'String'));
                a(9)=str2num(get(text_l,'String'));
                
                vals=double_peak_exp_bg(data,layer,lower,higher,lower_disp,higher_disp,a,f,ha,1);
            case 3
   
                a(1)=str2num(get(text_a,'String'));
                a(2)=str2num(get(text_b,'String'));
                a(3)=str2num(get(text_c,'String'));
                a(4)=str2num(get(text_d,'String'));
                a(5)=str2num(get(text_e,'String'));
                a(6)=str2num(get(text_f,'String'));
                a(7)=str2num(get(text_g,'String'));
                a(8)=str2num(get(text_h,'String'));
                a(9)=str2num(get(text_l,'String'));
                a(10)=str2num(get(text_m,'String'));
                a(11)=str2num(get(text_n,'String'));
                a(12)=str2num(get(text_o,'String'));
                
                
                vals=triple_peak_exp_bg(data,layer,lower,higher,lower_disp,higher_disp,a,f,ha,1);
                
        end
        
    end

    function Save_Callback(hObject,eventdata)
        data = guidata(f);
        layer=get(energy_list,'Value');
        
        lower=str2num(get(x_low,'String'));
        higher=str2num(get(x_high,'String'));
        lower_disp=str2num(get(x_low_disp,'String'));
        higher_disp=str2num(get(x_high_disp,'String'));
        
        f_type=get(fit_type,'Value');
     
        switch f_type
          
            case 1
   
                a(1)=str2num(get(text_a,'String'));
                a(2)=str2num(get(text_b,'String'));
                a(3)=str2num(get(text_c,'String'));
                a(4)=str2num(get(text_d,'String'));
                a(5)=str2num(get(text_e,'String'));
                a(6)=str2num(get(text_f,'String'));
                
                fit_or_not=get(dont_bother,'Value');
                
                vals=single_lorentzian_ebg(data,layer,lower,higher,lower_disp,higher_disp,a,f,ha,0);

                data.params(layer)={struct('lower',lower,'higher',higher,'a',a,'fit_or_not',fit_or_not,'fit_type',f_type,'vals',vals)};
                
                guidata(f,data);
                
                assignin('base', 'lc_fit_data', data)
                              
            case 2
                
                a(1)=str2num(get(text_a,'String'));
                a(2)=str2num(get(text_b,'String'));
                a(3)=str2num(get(text_c,'String'));
                a(4)=str2num(get(text_d,'String'));
                a(5)=str2num(get(text_e,'String'));
                a(6)=str2num(get(text_f,'String'));
                a(7)=str2num(get(text_g,'String'));
                a(8)=str2num(get(text_h,'String'));
                a(9)=str2num(get(text_l,'String'));
  
                fit_or_not=get(dont_bother,'Value');
                
                vals=double_peak_exp_bg(data,layer,lower,higher,lower_disp,higher_disp,a,f,ha,0);
                
                data.params(layer)={struct('lower',lower,'higher',higher,'a',a,'fit_or_not',fit_or_not,'fit_type',f_type,'vals',vals)};
                
                guidata(f,data);
                
                assignin('base', 'lc_fit_data', data)
                
            case 3
                
                a(1)=str2num(get(text_a,'String'));
                a(2)=str2num(get(text_b,'String'));
                a(3)=str2num(get(text_c,'String'));
                a(4)=str2num(get(text_d,'String'));
                a(5)=str2num(get(text_e,'String'));
                a(6)=str2num(get(text_f,'String'));
                a(7)=str2num(get(text_g,'String'));
                a(8)=str2num(get(text_h,'String'));
                a(9)=str2num(get(text_l,'String'));
                a(10)=str2num(get(text_m,'String'));
                a(11)=str2num(get(text_n,'String'));
                a(12)=str2num(get(text_o,'String'));
                
                fit_or_not=get(dont_bother,'Value');
                
                vals=triple_peak_exp_bg(data,layer,lower,higher,lower_disp,higher_disp,a,f,ha,0);
               
                data.params(layer)={struct('lower',lower,'higher',higher,'a',a,'fit_or_not',fit_or_not,'fit_type',f_type,'vals',vals)};
                
                guidata(f,data);
                
                assignin('base', 'lc_fit_data', data)
                
        end
    end

    function Fit_Callback(hObject,eventdata)
        
        data = guidata(f);
        layer=get(energy_list,'Value');
        
        lower=str2num(get(x_low,'String'));
        higher=str2num(get(x_high,'String'));
        lower_disp=str2num(get(x_low_disp,'String'));
        higher_disp=str2num(get(x_high_disp,'String'));
        
        f_type=get(fit_type,'Value');
      
        switch f_type
            
            case 1
                
                a(1)=str2num(get(text_a,'String'));
                a(2)=str2num(get(text_b,'String'));
                a(3)=str2num(get(text_c,'String'));
                a(4)=str2num(get(text_d,'String'));
                a(5)=str2num(get(text_e,'String'));
                a(6)=str2num(get(text_f,'String'));
                
                q1_vals=single_lorentzian_ebg(data, layer, lower, higher,lower_disp,higher_disp, a,f,ha,0);
              
            case 2
                
                a(1)=str2num(get(text_a,'String'));
                a(2)=str2num(get(text_b,'String'));
                a(3)=str2num(get(text_c,'String'));
                a(4)=str2num(get(text_d,'String'));
                a(5)=str2num(get(text_e,'String'));
                a(6)=str2num(get(text_f,'String'));
                a(7)=str2num(get(text_g,'String'));
                a(8)=str2num(get(text_h,'String'));
                a(9)=str2num(get(text_l,'String'));

                vals=double_peak_exp_bg(data,layer,lower,higher,lower_disp,higher_disp,a,f,ha,0);
                 
            case 3
                
                a(1)=str2num(get(text_a,'String'));
                a(2)=str2num(get(text_b,'String'));
                a(3)=str2num(get(text_c,'String'));
                a(4)=str2num(get(text_d,'String'));
                a(5)=str2num(get(text_e,'String'));
                a(6)=str2num(get(text_f,'String'));
                a(7)=str2num(get(text_g,'String'));
                a(8)=str2num(get(text_h,'String'));
                a(9)=str2num(get(text_l,'String'));
                a(10)=str2num(get(text_m,'String'));
                a(11)=str2num(get(text_n,'String'));
                a(12)=str2num(get(text_o,'String'));
                vals=triple_peak_exp_bg(data,layer,lower,higher,lower_disp,higher_disp,a,f,ha,0);
        end
    end

    function Export_Callback(hObject,eventdata)
        data = guidata(f);
        q=repmat([NaN NaN NaN],length(data.e),1);
        for i=1:length(data.e);
            if ~isempty(data.params{i})
                if data.params{i}.fit_or_not==1
                    q(i,:)= return_vectors(data.params{i});
                end
            end
            assignin('base', 'q', q)
            assignin('base','energies',data.e);
        end
    end
end



