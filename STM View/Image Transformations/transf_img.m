function new_data = transf_img(data,t_matrix,varargin)
if isstruct(data)
    map = data.map;
    coord = data.r;
else
    map = data;
    if nargin > 2
        coord = varargin{1};
    else
        display('No coordinates provides')
        return;
    end
end
xform = t_matrix;
gtform = maketform('affine',xform');
new_map = imtransform(map, gtform,'linear',... 
                        'UData',[coord(1) coord(end)],...
                        'VData', [coord(1) coord(end)],...
                        'XData',[coord(1) coord(end)],...
                        'YData', [coord(1) coord(end)],...
                        'size', size(map)); 
                    
if isstruct(data)
    new_data = data;
    new_data.map = new_map;
    new_data.var = [new_data.var 'aff_Tr'];
else
    new_data = new_map;
end
end