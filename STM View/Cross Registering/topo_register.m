function [ ] = topo_register( topo_1,topo_2 )

Fixed=topo_1.map;
Moving=topo_2.map;

theta1_moving=topo_2.phase_map.theta1;
theta2_moving=topo_2.phase_map.theta2;
s_phase1_moving=topo_2.phase_map.s_phase1;
s_phase2_moving=topo_2.phase_map.s_phase2;
theta1_old_moving=topo_2.phase_map.theta1_old;
theta2_old_moving=topo_2.phase_map.theta2_old;

figure;
imshowpair(Fixed,Moving,'montage');
[optimizer,metric] = imregconfig('monomodal');
t_form=imregtform(Moving,Fixed,'affine',optimizer,metric);
registered=imwarp(Moving, t_form, 'OutputView', imref2d(size( Fixed)));
% 
% t_form=topo_2.t_form;
theta1_registered=imwarp(theta1_moving, t_form, 'OutputView', imref2d(size(Fixed)));
theta2_registered=imwarp(theta2_moving, t_form, 'OutputView', imref2d(size(Fixed)));
s_phase1_registered=imwarp(s_phase1_moving, t_form, 'OutputView', imref2d(size(Fixed)));
s_phase2_registered=imwarp(s_phase2_moving, t_form, 'OutputView', imref2d(size(Fixed)));
theta1_old_registered=imwarp(theta1_old_moving, t_form, 'OutputView', imref2d(size(Fixed)));
theta2_old_registered=imwarp(theta2_old_moving, t_form, 'OutputView', imref2d(size(Fixed)));

output_data=topo_2;
output_data.map=registered;
output_data.r = topo_1.r; % assign coordinates from unmoved image to move one
output_data.phase_map.theta1=theta1_registered;
output_data.phase_map.theta2=theta2_registered;
output_data.phase_map.s_phase1=s_phase1_registered;
output_data.phase_map.s_phase2=s_phase2_registered;
output_data.phase_map.theta1_old=theta1_old_registered;
output_data.phase_map.theta2_old=theta2_old_registered;

output_data.t_form.T = t_form;
output_data.t_form.size = size(Fixed);
output_data.t_form.r = topo_1.r;

output_data.var = [output_data.var '_registered'];
    output_data.ops{end+1} = 'Registration';
    
   IMG(output_data);

end

