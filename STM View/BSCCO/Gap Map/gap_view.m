function gap_view(data,gapmap,r,c)
y = squeeze(data.map(r,c,:));
x = data.e;

figure; plot(x,y);
gap_val = gapmap(r,c);
hold on; plot([gap_val gap_val], get(gca,'ylim'),'r');
title(['x: ' num2str(c) ' - y: ' num2str(r) ' gapval = ' num2str(gap_val)]);

end