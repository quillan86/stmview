function linecut_waterfall(cut)
if isstruct(cut)
    img = cut.cut;
    r = cut.r/1.77;
    e = cut.e*1000;
else
    img = cut;
    r = linspace(1,size(cut,1));
    e = linspace(1,size(cut,2));
end

figure; imagesc(abs(r-r(end)),e,fliplr(img'));
xlim([0.1 1.01])
colormap(get_color_map('Defect0'));
end
