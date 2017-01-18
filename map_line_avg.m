y = 0; y2 = 0; y3 = 0;
for lyr = 1:17
for i = 1:128
    y(i) =  mean(map(i,1:end,lyr));
    y2(i) = mean(map2(i,1:end,lyr));
    y3(i) = mean(map3(i,1:end,lyr));    
end

end
figure; plot(y/max(y),'r'); hold on; plot(y2/max(y2),'b'); hold on; plot(y3/max(y3),'g');