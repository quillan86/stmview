function new_data =  map_to_power(data,power)
if isstruct(data)
    map = data.map;
    new_data = data;
    new_data.map = map.^power;
    new_data.var = [new_data.var '_power_' num2str(power)];
    new_data.ops{end+1} = ['Map to power ' num2str(power)];
    if data.type == 0 || data.type == 1
        new_data.avg = map_avg_spectrum(new_data);
    end
    IMG(new_data);
else
    map = data;
    new_data = map.^power;
end



end