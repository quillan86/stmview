function color_map = get_color_map(color_map_name)
color_map_path = color_directory;

color_map = struct2cell(load([color_map_path color_map_name '.mat']));
color_map = color_map{1};

end