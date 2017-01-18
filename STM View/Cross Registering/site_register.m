function [ ] = site_register( moving, fixed )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

registered=moving;


movingPoints=unique([moving.Cu_index;moving.Ox_index1;moving.Ox_index2;moving.Oy_index1;moving.Oy_index2],'rows');
fixedPoints=unique([fixed.Cu_index;fixed.Ox_index1;fixed.Ox_index2;fixed.Oy_index1;fixed.Oy_index2],'rows');

[movingPoints fixedPoints]=pair_atoms(movingPoints,fixedPoints);

t_form = fitgeotrans(movingPoints,fixedPoints,'pwl');

registered.t_form_local=t_form;

registered.map=imwarp(moving.map, t_form, 'OutputView', imref2d(size( fixed.map)));
registered=phase_map_warp(registered);

phase_map = registered.phase_map;
        registered.Cu =  atomic_pos(phase_map,0,0);
        registered.Ox =  atomic_pos(phase_map,pi,0);
        registered.Oy =  atomic_pos(phase_map,0,pi);
        [Cu_index Ox_index1 Ox_index2 Oy_index1 Oy_index2] = BSCCO_Cu_O_index(registered.Cu,registered.Ox,registered.Oy);
        registered.Cu_index_new = Cu_index;
        registered.Ox_index1_new = Ox_index1; registered.Ox_index2_new = Ox_index2; 
        registered.Oy_index_new = Oy_index1; registered.Oy_index2_new = Oy_index2;
        
        
        
        
        registered.Cu=fixed.Cu;registered.Ox=fixed.Ox;registered.Oy=fixed.Oy;
        registered.Cu_index=fixed.Cu_index;registered.Ox_index1=fixed.Ox_index1;registered.Ox_index2=fixed.Ox_index2;registered.Oy_index1=fixed.Oy_index1;
        registered.Oy_index2=fixed.Oy_index2;
        
        
%      newPoints=unique([registered.Cu_index;registered.Ox_index1;registered.Ox_index2;registered.Oy_index1;registered.Oy_index2],'rows');   
     
registered.var = [registered.var '_registered_local'];
    registered.ops{end+1} = 'Site_reg';

 IMG(registered);
 



end

