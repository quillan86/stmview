function imagesc_normal(img)
imagesc(flipud(img));
set(gca,'YDir','normal');
end