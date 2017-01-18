data = lc_fit_data_vortex_FT;
       layer=1; 
       
       lower=0.01;
       higher=2.3;
       
       f_type=3;
       
       
       switch f_type
           
           
           
           
           case 1
               
       a(1)=str2num(get(text_a,'String'));
       a(2)=str2num(get(text_b,'String'));
       a(3)=str2num(get(text_c,'String'));
       a(4)=str2num(get(text_d,'String'));
       a(5)=str2num(get(text_e,'String'));
       a(6)=str2num(get(text_f,'String'));
       
       
      q1_vals=single_lorentzian_ebg(data, layer, lower, higher, a,f,ha,0);
               
               
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
       
%        x_data=data.r(1:25);
%        y_data=data.cut(1:25,layer);
%        
%        
%        lor_exp_bg=@(a,b,c,d,e,f,g,h,l,x)...
%     a*exp(-b.*x)+c+d./((x-e).^2+f^2)+g./((x-h).^2+l^2);
% 
% 
%     lor=@(d,e,f,x)...
%     d./((x-e).^2+f^2);
% 
% q1_fit=fit(x_data,y_data,lor_exp_bg,...
% 'StartPoint', [a_1,b_1,c_1,d_1,e_1,f_1,g_1,h_1,l_1],...
% 'Upper' );

vals=double_peak_exp_bg(data,layer,lower,higher,a,f,ha,0);   


%        axes(ha)
%        
%        
%       plot(linspace(0,1,200),lor_exp_bg(q1_vals(1),q1_vals(2),q1_vals(3),q1_vals(4),q1_vals(5),q1_vals(6),q1_vals(7),q1_vals(8),q1_vals(9),linspace(0,1,200)),x_data,y_data,'ok');
%       
%       hold on
%       
%       plot(linspace(0,1,200),lor(q1_vals(4),q1_vals(5),q1_vals(6),linspace(0,1,200)),'-g');
%       plot(linspace(0,1,200),lor(q1_vals(7),q1_vals(8),q1_vals(9),linspace(0,1,200)),'-r')
% %        plot(linspace(0,1,200),lor_exp_bg(a_1,b_1,c_1,d_1,e_1,f_1,g_1,h_1,l_1,linspace(0,1,200)),x_data,y_data,'ok')
% %        
%        hold off
%       
%       xlim([0 2]);
               
           case 3 
               
               
             d_lor_exp_bg=@(a,b,c,d,e,f,g,h,l,m,n,p,x)...
    a*exp(-b.*x)+c+d./((x-e).^2+f^2)+g./((x-h).^2+l^2)+m./((x-n).^2+p^2);  
                  
       a=data.params{1}.a;
       
       
               
       vals=triple_peak_exp_bg(data,layer,lower,higher,a,1,h,0);           
               
              figure(1)

              axes(h)
       
       
      plot(linspace(lower,higher,500) ./ 1.7562 ,d_lor_exp_bg(vals(1),vals(2),vals(3),vals(4),vals(5),vals(6),vals(7),vals(8),vals(9),vals(10),vals(11),vals(12),linspace(lower,higher,500)),data.r ./ 1.7562,data.cut(:,layer),'ok');
       xlim([min(data.r) max(data.r)]); 
               
       end