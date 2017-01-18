function [ out_data] = phase_crop( in_data,x1,x2,y1,y2 )
%crops phase map and atom indices

out_data=in_data;

out_data.phase_map.theta1=crop_img(in_data.phase_map.theta1,x1,x2,y1,y2);
out_data.phase_map.theta2=crop_img(in_data.phase_map.theta2,x1,x2,y1,y2);
out_data.phase_map.s_phase1=crop_img(in_data.phase_map.s_phase1,x1,x2,y1,y2);
out_data.phase_map.s_phase2=crop_img(in_data.phase_map.s_phase2,x1,x2,y1,y2);
out_data.phase_map.theta1_old=crop_img(in_data.phase_map.theta1_old,x1,x2,y1,y2);
out_data.phase_map.theta2_old=crop_img(in_data.phase_map.theta2_old,x1,x2,y1,y2);

out_data.Cu=crop_img(in_data.Cu,x1,x2,y1,y2);
out_data.Ox=crop_img(in_data.Ox,x1,x2,y1,y2);
out_data.Oy=crop_img(in_data.Oy,x1,x2,y1,y2);

[Cu_index Ox_index1 Ox_index2 Oy_index1 Oy_index2] = BSCCO_Cu_O_index(out_data.Cu,out_data.Ox,out_data.Oy);
        out_data.Cu_index = Cu_index;
        out_data.Ox_index1 = Ox_index1; out_data.Ox_index2 = Ox_index2; 
        out_data.Oy_index1 = Oy_index1; out_data.Oy_index2 = Oy_index2;



end

