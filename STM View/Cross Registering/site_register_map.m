function [ ] = site_register_map( in )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here


registered=in;

t_form=in.t_form_local;


for i=1:size(in.map,3)
registered.map(:,:,i)=imwarp(in.map(:,:,i), t_form, 'OutputView', imref2d(size( in.map(:,:,i))));
end

registered=phase_map_warp(in);

registered.var = [registered.var '_registered_local'];
    registered.ops{end+1} = 'Site_reg';

 IMG(registered);




end

