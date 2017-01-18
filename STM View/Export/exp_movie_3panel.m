function movie1 = exp_movie_3panel(map1,map2,map3,e1,e2,e3,rx1,ry1,rx2,ry2,rx3,ry3,directory,filename,clmap,clbnd1,clbnd2,clbnd3,frps,quality)
% XXX arpes movie maker
% XXX makes movie from one matrix block

f1=figure('Position',[100,100,650,250]);
set(f1,'Color',[0 0 0])

[sy,sx,sz]=size(map1);
colormap(clmap)
path = strcat(directory,filename);

for i=1:sz
     plane1 = map1(:,:,i);      
     set(gca,'Position',[0 0 1 1]);         
     %axis equal; axis off;              
     subplot(1,3,1);
     imagesc(rx1,ry1,squeeze(plane1)); axis off; axis equal 
     hold on;
     text(0.1,0.0,[num2str(e1(i)*1000,'%6.2f'),' meV'],'Units','normalized',...
            'Fontsize',16,'Color',[1 1 1]);

    mini1 = clbnd1(i,1); maxi1 = clbnd1(i,2);
    caxis([mini1 maxi1]);
    set(gca, 'NextPlot', 'replace');
    hold off;
    subplot(1,3,2);
    plane2 = map2(:,:,i);
     imagesc(rx2,ry2,squeeze(plane2)); axis off; axis equal 
     hold on;
     text(0.1,0.0,[num2str(e2(i)*1000,'%6.2f'),' meV'],'Units','normalized',...
            'Fontsize',16,'Color',[1 1 1]);

    mini2 = clbnd2(i,1); maxi2 = clbnd2(i,2);
    caxis([mini2 maxi2]);
    hold off;
    subplot(1,3,3);
    plane3 = map3(:,:,i);
     imagesc(rx3,ry3,squeeze(plane3)); axis off; axis equal 
     hold on;
     text(0.1,0.0,[num2str(e3(i)*1000,'%6.2f'),' meV'],'Units','normalized',...
            'Fontsize',16,'Color',[1 1 1]);
    mini3 = clbnd3(i,1); maxi3 = clbnd3(i,2);
    caxis([mini3 maxi3]);
    
    movie1(:,i)=getframe(gcf);
    set(gca, 'NextPlot', 'replace');
    %hold off;
end
movie2avi(movie1, path,'compression','none','fps',frps,'quality',quality);
end