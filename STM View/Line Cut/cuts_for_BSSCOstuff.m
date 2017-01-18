%%
cut = cut_8;
nrm = 1.3;
lyr = 14;
figure; 
plot(cut.r/nrm,fastsmooth(cut.cut(:,lyr),2,2,0),'r');
xlim([0.05 1.1]);
title(['layer ' num2str(lyr) ' = '  num2str(1000*cut.e(lyr)) 'meV']);
cut = cut_0;

%figure; 
hold on;
plot(cut.r/nrm,fastsmooth(cut.cut(:,lyr),2,2,0),'b');
xlim([0.05 1.1]);
title(['layer ' num2str(lyr) ' = '  num2str(1000*cut.e(lyr)) 'meV']);
figure(gcf)

% hold on;
% plot(cut.r/nrm,fastsmooth(cut_8.cut(:,lyr)-cut_0.cut(:,lyr),2,2,1),'k--');
% xlim([0.05 1.1]);
% title(['layer ' num2str(lyr) ' = '  num2str(1000*cut.e(lyr)) 'meV']);
% figure(gcf)

hold on;
plot(cut.r/nrm,fastsmooth(cut_subt.cut(:,lyr),2,2,1),'k--');
xlim([0.05 1.1]);
title(['layer ' num2str(lyr) ' = '  num2str(1000*cut.e(lyr)) 'meV']);
figure(gcf)
ylim([0 600])