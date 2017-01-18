function movie1 = exp_movie_2panel(map1,map2,energy1,energy2,rx1,ry1,rx2,ry2,directory,filename,clmap,clbnd1,clbnd2,frps,quality)
% XXX arpes movie maker
% XXX makes movie from one matrix block

f1=figure('Position',[100,100,450,250],'MenuBar','none');
set(f1,'Color',[0.2 0.2 0.2])

[sy,sx,sz]=size(map1);
colormap(clmap)
path = strcat(directory,filename);

for i=1:sz
     plane1 = map1(:,:,i);      
     set(gca,'Position',[0 0 1 1]);         
     %axis equal; axis off;              
     subplot(1,2,1);
     imagesc(rx1,ry1,squeeze(plane1)); axis off; axis equal 
     hold on;
     text(0.1,0.0,[num2str(energy1(i)*1000,'%6.2f'),' meV'],'Units','normalized',...
            'Fontsize',16,'Color',[1 1 1]);

    mini1 = clbnd1(i,1); maxi1 = clbnd1(i,2);
    caxis([mini1 maxi1]);
    set(gca, 'NextPlot', 'replace');
    hold off;
    subplot(1,2,2);
    plane2 = map2(:,:,i);
     imagesc(rx2,ry2,squeeze(plane2)); axis off; axis equal 
     hold on;
     text(0.1,0.0,[num2str(energy2(i)*1000,'%6.2f'),' meV'],'Units','normalized',...
            'Fontsize',16,'Color',[1 1 1]);

    mini2 = clbnd2(i,1); maxi2 = clbnd2(i,2);
    caxis([mini2 maxi2]);
    
    movie1(:,i)=getframe(gcf);
    set(gca, 'NextPlot', 'replace');
    %hold off;
end
movie2avi(movie1, path,'compression','none','fps',frps,'quality',quality);
end