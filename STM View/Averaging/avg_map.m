function avg = avg_map(map)
avg = squeeze(squeeze(mean(mean(map))));
end