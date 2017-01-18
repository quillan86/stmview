function avg_spectrum = map_avg_spectrum(data)
if isstruct(data)    
    avg_spectrum = squeeze(squeeze(mean(mean(data.map))));
else
    avg_spectrum = squeeze(squeeze(mean(mean(data))));
end
end