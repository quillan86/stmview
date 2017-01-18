clear corr_mat;
for k = 1:17
    corr_mat(1,k,1) = corr2(QPI_B_25mT.map(:,:,k),QPI_B_25mT.map(:,:,k));
    corr_mat(2,k,1) = corr2(QPI_B_25mT.map(:,:,k),QPI_B_150mT.map(:,:,k));
    corr_mat(3,k,1) = corr2(QPI_B_25mT.map(:,:,k),QPI_B_400mT.map(:,:,k));
    corr_mat(4,k,1) = corr2(QPI_B_25mT.map(:,:,k),QPI_B_660mT.map(:,:,k));
    corr_mat(5,k,1) = corr2(QPI_B_25mT.map(:,:,k),QPI_B_1000mT.map(:,:,k));
    
    corr_mat(1,k,2) = corr2(QPI_B_150mT.map(:,:,k),QPI_B_25mT.map(:,:,k));
    corr_mat(2,k,2) = corr2(QPI_B_150mT.map(:,:,k),QPI_B_150mT.map(:,:,k));
    corr_mat(3,k,2) = corr2(QPI_B_150mT.map(:,:,k),QPI_B_400mT.map(:,:,k));
    corr_mat(4,k,2) = corr2(QPI_B_150mT.map(:,:,k),QPI_B_660mT.map(:,:,k));
    corr_mat(5,k,2) = corr2(QPI_B_150mT.map(:,:,k),QPI_B_1000mT.map(:,:,k));
    
    corr_mat(1,k,3) = corr2(QPI_B_400mT.map(:,:,k),QPI_B_25mT.map(:,:,k));
    corr_mat(2,k,3) = corr2(QPI_B_400mT.map(:,:,k),QPI_B_150mT.map(:,:,k));
    corr_mat(3,k,3) = corr2(QPI_B_400mT.map(:,:,k),QPI_B_400mT.map(:,:,k));
    corr_mat(4,k,3) = corr2(QPI_B_400mT.map(:,:,k),QPI_B_660mT.map(:,:,k));
    corr_mat(5,k,3) = corr2(QPI_B_400mT.map(:,:,k),QPI_B_1000mT.map(:,:,k));
    
    corr_mat(1,k,4) = corr2(QPI_B_660mT.map(:,:,k),QPI_B_25mT.map(:,:,k));
    corr_mat(2,k,4) = corr2(QPI_B_660mT.map(:,:,k),QPI_B_150mT.map(:,:,k));
    corr_mat(3,k,4) = corr2(QPI_B_660mT.map(:,:,k),QPI_B_400mT.map(:,:,k));
    corr_mat(4,k,4) = corr2(QPI_B_660mT.map(:,:,k),QPI_B_660mT.map(:,:,k));
    corr_mat(5,k,4) = corr2(QPI_B_660mT.map(:,:,k),QPI_B_1000mT.map(:,:,k));
    
    corr_mat(1,k,5) = corr2(QPI_B_1000mT.map(:,:,k),QPI_B_25mT.map(:,:,k));
    corr_mat(2,k,5) = corr2(QPI_B_1000mT.map(:,:,k),QPI_B_150mT.map(:,:,k));
    corr_mat(3,k,5) = corr2(QPI_B_1000mT.map(:,:,k),QPI_B_400mT.map(:,:,k));
    corr_mat(4,k,5) = corr2(QPI_B_1000mT.map(:,:,k),QPI_B_660mT.map(:,:,k));
    corr_mat(5,k,5) = corr2(QPI_B_1000mT.map(:,:,k),QPI_B_1000mT.map(:,:,k));
end
img_plot2(corr_mat(:,:,5));
%%
for k = 1:17
corr_mat2(1,k,1) = corr2(QPI_B_25mT.map(:,:,k),QPI_B_25mT_200mK.map(:,:,k));
end

%%
clear noise;
for k = 1:17
    noise(k) = sum(sum(QPI_B_25mT.map(1:20,1:20,k)))/sum(sum(QPI_B_25mT.map(:,:,k)));
end
figure; plot(e,noise)
%%
A = magic(10);
a = rand(10,10); a = a*25;
corr2(A,A+a)