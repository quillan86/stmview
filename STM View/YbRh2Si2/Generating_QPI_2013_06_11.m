

%% dataset 30522A01
path_root = 'C:\Data\stm data\RUN067\YRS\130522\';
obj_30522A01_G = read_map_no_dialogue('30522A01.2FL', path_root);
obj_30522A01_I = read_map_no_dialogue('30522A01.1FL', path_root);
G_50mT_30mK = current_divide2(obj_30522A01_G,obj_30522A01_I);
[nr nc nz] = size(G_50mT_30mK.map);
% calculate average power in each  real space layer before being
% processed - this sets a more definitive normalization value for bilateral filter      

for i = 1:nz
    mval(i) = abs(mean(mean(G_50mT_30mK.map(:,:,i))))*nr*nc;
end
G_50mT_30mK = polyn_subtract(G_50mT_30mK,2);
G_50mT_30mK_FT = fourier_transform2d(G_50mT_30mK,'none','amplitude','ft');
G_50mT_30mK_FT = symmetrize_image_v2(G_50mT_30mK_FT,'vd');
G_50mT_30mK_FT_bfilt = G_50mT_30mK_FT;
old_map = G_50mT_30mK_FT.map;

h = waitbar(0,'Applying bilateral filter to Layers...');
set(h,'Name','Bilateral Filter Progress');       
for i = 1:nz           
           img = old_map(:,:,i);               
           max_val = m_val(i);
           new_map(:,:,i) = bilateral_filt(img/max_val,5,[1.5 0.0005])*max_val;
           waitbar(i/nz,h,[num2str(i/nz*100) '%']);
end
close(h);
G_50mT_30mK_FT_bfilt.map = new_map;
clear nc nc nz img old_map new_map

old_map = G_50mT_30mK_FT_bfilt.map;
new_map = rm_center(old_map,3.5);
G_50mT_30mK_FT_bfilt.map = new_map;

clear old_map clear new_map
%%
%% dataset 30523A01
%dir_path = '130523';
path_root = 'C:\Data\stm data\RUN067\YRS\130523\';
obj_30523A01_G = read_map_no_dialogue('30523A01.2FL', path_root);
obj_30523A01_I = read_map_no_dialogue('30523A01.1FL', path_root);
G_100mT_30mK = current_divide2(obj_30523A01_G,obj_30523A01_I);

[nr nc nz] = size(G_100mT_30mK.map);
% calculate average power in each  real space layer before being
% processed - this sets a more definitive normalization value for bilateral filter      

for i = 1:nz
    mval(i) = abs(mean(mean(G_100mT_30mK.map(:,:,i))))*nr*nc;
end

G_100mT_30mK = polyn_subtract(G_100mT_30mK,2);
G_100mT_30mK_FT = fourier_transform2d(G_100mT_30mK,'none','amplitude','ft');
G_100mT_30mK_FT = symmetrize_image_v2(G_100mT_30mK_FT,'vd');
G_100mT_30mK_FT_bfilt = G_100mT_30mK_FT;
old_map = G_100mT_30mK_FT.map;
h = waitbar(0,'Applying bilateral filter to Layers...');
set(h,'Name','Bilateral Filter Progress');       
for i = 1:nz           
           img = old_map(:,:,i);
           max_val = mval(i);
           new_map(:,:,i) = bilateral_filt(img/max_val,5,[1.5 0.0005])*max_val;
           waitbar(i/nz,h,[num2str(i/nz*100) '%']);
end
close(h);
G_100mT_30mK_FT_bfilt.map = new_map;
clear nc nc nz img old_map new_map

old_map = G_100mT_30mK_FT_bfilt.map;
new_map = rm_center(old_map,3.5);
G_100mT_30mK_FT_bfilt.map = new_map;

clear old_map clear new_map
%%
%% dataset 30603A00
path_root = 'C:\Data\stm data\RUN067\YRS\130603\';
obj_30603A00_G = read_map_no_dialogue('30603A00.2FL', path_root);
obj_30603A00_I = read_map_no_dialogue('30603A00.1FL', path_root);
G_150mT_30mK = current_divide2(obj_30603A00_G,obj_30603A00_I);

[nr nc nz] = size(G_150mT_30mK.map);
% calculate average power in each  real space layer before being
% processed - this sets a more definitive normalization value for bilateral filter      

for i = 1:nz
    mval(i) = abs(mean(mean(G_150mT_30mK.map(:,:,i))))*nr*nc;
end

G_150mT_30mK = polyn_subtract(G_150mT_30mK,2);
G_150mT_30mK_FT = fourier_transform2d(G_150mT_30mK,'none','amplitude','ft');
G_150mT_30mK_FT = symmetrize_image_v2(G_150mT_30mK_FT,'vd');
G_150mT_30mK_FT_bfilt = G_150mT_30mK_FT;
old_map = G_150mT_30mK_FT.map;
h = waitbar(0,'Applying bilateral filter to Layers...');
set(h,'Name','Bilateral Filter Progress');       
for i = 1:nz           
           img = old_map(:,:,i);
           max_val = mval(i);
           new_map(:,:,i) = bilateral_filt(img/max_val,5,[1.5 0.0005])*max_val;
           waitbar(i/nz,h,[num2str(i/nz*100) '%']);
end
close(h);
G_150mT_30mK_FT_bfilt.map = new_map;
clear nc nc nz img old_map new_map

old_map = G_150mT_30mK_FT_bfilt.map;
new_map = rm_center(old_map,3.5);
G_150mT_30mK_FT_bfilt.map = new_map;

clear old_map clear new_map
%%
%% dataset 30605A02
path_root = 'C:\Data\stm data\RUN067\YRS\130605\';
obj_30605A02_G = read_map_no_dialogue('30605A02.2FL', path_root);
obj_30605A02_I = read_map_no_dialogue('30605A02.1FL', path_root);
G_660mT_30mK = current_divide2(obj_30605A02_G,obj_30605A02_I);

[nr nc nz] = size(G_660mT_30mK.map);
% calculate average power in each  real space layer before being
% processed - this sets a more definitive normalization value for bilateral filter      

for i = 1:nz
    mval(i) = abs(mean(mean(G_660mT_30mK.map(:,:,i))))*nr*nc;
end

G_660mT_30mK = polyn_subtract(G_660mT_30mK,2);
G_660mT_30mK_FT = fourier_transform2d(G_660mT_30mK,'none','amplitude','ft');
G_660mT_30mK_FT = symmetrize_image_v2(G_660mT_30mK_FT,'vd');
G_660mT_30mK_FT_bfilt = G_660mT_30mK_FT;
old_map = G_660mT_30mK_FT.map;
h = waitbar(0,'Applying bilateral filter to Layers...');
set(h,'Name','Bilateral Filter Progress');       
for i = 1:nz           
           img = old_map(:,:,i);
           max_val = mval(i);
           new_map(:,:,i) = bilateral_filt(img/max_val,5,[1.5 0.0005])*max_val;
           waitbar(i/nz,h,[num2str(i/nz*100) '%']);
end
close(h);
G_660mT_30mK_FT_bfilt.map = new_map;
clear nc nc nz img old_map new_map

old_map = G_660mT_30mK_FT_bfilt.map;
new_map = rm_center(old_map,3.5);
G_660mT_30mK_FT_bfilt.map = new_map;

clear old_map clear new_map
%%
%% dataset 30609A00
path_root = 'C:\Data\stm data\RUN067\YRS\130609\';
obj_30609A00_G = read_map_no_dialogue('30609A00.2FL', path_root);
obj_30609A00_I = read_map_no_dialogue('30609A00.1FL', path_root);
G_1000mT_30mK = current_divide2(obj_30609A00_G,obj_30609A00_I);

[nr nc nz] = size(G_1000mT_30mK.map);
% calculate average power in each  real space layer before being
% processed - this sets a more definitive normalization value for bilateral filter      

for i = 1:nz
    mval(i) = abs(mean(mean(G_1000mT_30mK.map(:,:,i))))*nr*nc;
end


G_1000mT_30mK = polyn_subtract(G_1000mT_30mK,2);
G_1000mT_30mK_FT = fourier_transform2d(G_1000mT_30mK,'none','amplitude','ft');
G_1000mT_30mK_FT = symmetrize_image_v2(G_1000mT_30mK_FT,'vd');
G_1000mT_30mK_FT_bfilt = G_1000mT_30mK_FT;
old_map = G_1000mT_30mK_FT.map;
h = waitbar(0,'Applying bilateral filter to Layers...');
set(h,'Name','Bilateral Filter Progress');       
for i = 1:nz           
           img = old_map(:,:,i);
           max_val = mval(i);
           new_map(:,:,i) = bilateral_filt(img/max_val,5,[1.5 0.0005])*max_val;
           waitbar(i/nz,h,[num2str(i/nz*100) '%']);
end
close(h);
G_1000mT_30mK_FT_bfilt.map = new_map;
clear nc nc nz img old_map new_map

old_map = G_1000mT_30mK_FT_bfilt.map;
new_map = rm_center(old_map,3.5);
G_1000mT_30mK_FT_bfilt.map = new_map;

clear old_map clear new_map
%%
%% dataset 306012A01
path_root = 'C:\Data\stm data\RUN067\YRS\130612\';
obj_30612A01_G = read_map_no_dialogue('30612A01.2FL', path_root);
obj_30612A01_I = read_map_no_dialogue('30612A01.1FL', path_root);
G_400mT_30mK = current_divide2(obj_30612A01_G,obj_30612A01_I);

[nr nc nz] = size(G_400mT_30mK.map);
% calculate average power in each  real space layer before being
% processed - this sets a more definitive normalization value for bilateral filter      

for i = 1:nz
    mval(i) = abs(mean(mean(G_400mT_30mK.map(:,:,i))))*nr*nc;
end


G_400mT_30mK = polyn_subtract(G_400mT_30mK,2);
G_400mT_30mK_FT = fourier_transform2d(G_400mT_30mK,'none','amplitude','ft');
G_400mT_30mK_FT = symmetrize_image_v2(G_400mT_30mK_FT,'vd');
G_400mT_30mK_FT_bfilt = G_400mT_30mK_FT;
old_map = G_400mT_30mK_FT.map;
h = waitbar(0,'Applying bilateral filter to Layers...');
set(h,'Name','Bilateral Filter Progress');       
for i = 1:nz           
           img = old_map(:,:,i);
           max_val = mval(i);
           new_map(:,:,i) = bilateral_filt(img/max_val,5,[1.5 0.0005])*max_val;
           waitbar(i/nz,h,[num2str(i/nz*100) '%']);
end
close(h);
G_400mT_30mK_FT_bfilt.map = new_map;
clear nc nc nz img old_map new_map

old_map = G_400mT_30mK_FT_bfilt.map;
new_map = rm_center(old_map,3.5);
G_400mT_30mK_FT_bfilt.map = new_map;

clear old_map clear new_map
%%
%% dataset 306014A00
path_root = 'C:\Data\stm data\RUN067\YRS\130614\';
obj_30614A00_G = read_map_no_dialogue('30614A00.2FL', path_root);
obj_30614A00_I = read_map_no_dialogue('30614A00.1FL', path_root);
G_25mT_30mK = current_divide2(obj_30614A00_G,obj_30614A00_I);

[nr nc nz] = size(G_25mT_30mK.map);
% calculate average power in each  real space layer before being
% processed - this sets a more definitive normalization value for bilateral filter      

for i = 1:nz
    mval(i) = abs(mean(mean(G_25mT_30mK.map(:,:,i))))*nr*nc;
end


G_25mT_30mK = polyn_subtract(G_25mT_30mK,2);
G_25mT_30mK_FT = fourier_transform2d(G_25mT_30mK,'none','amplitude','ft');
G_25mT_30mK_FT = symmetrize_image_v2(G_25mT_30mK_FT,'vd');
G_25mT_30mK_FT_bfilt = G_25mT_30mK_FT;
old_map = G_25mT_30mK_FT.map;
h = waitbar(0,'Applying bilateral filter to Layers...');
set(h,'Name','Bilateral Filter Progress');       
for i = 1:nz           
           img = old_map(:,:,i);
           max_val = mval(i);
           new_map(:,:,i) = bilateral_filt(img/max_val,5,[1.5 0.0005])*max_val;
           waitbar(i/nz,h,[num2str(i/nz*100) '%']);
end
close(h);
G_25mT_30mK_FT_bfilt.map = new_map;
clear nc nc nz img old_map new_map

old_map = G_25mT_30mK_FT_bfilt.map;
new_map = rm_center(old_map,3.5);
G_25mT_30mK_FT_bfilt.map = new_map;

clear old_map clear new_map

%%
%% dataset 306016A00
path_root = 'C:\Data\stm data\RUN067\YRS\130616\';
obj_30616A00_G = read_map_no_dialogue('30616A00.2FL', path_root);
obj_30616A00_I = read_map_no_dialogue('30616A00.1FL', path_root);
G_25mT_30mK_B = current_divide2(obj_30616A00_G,obj_30616A00_I);

[nr nc nz] = size(G_25mT_30mK_B.map);
% calculate average power in each  real space layer before being
% processed - this sets a more definitive normalization value for bilateral filter      

for i = 1:nz
    mval(i) = abs(mean(mean(G_25mT_30mK_B.map(:,:,i))))*nr*nc;
end


G_25mT_30mK_B = polyn_subtract(G_25mT_30mK_B,2);
G_25mT_30mK_B_FT = fourier_transform2d(G_25mT_30mK_B,'none','amplitude','ft');
G_25mT_30mK_B_FT = symmetrize_image_v2(G_25mT_30mK_B_FT,'vd');
G_25mT_30mK_B_FT_bfilt = G_25mT_30mK_B_FT;
old_map = G_25mT_30mK_B_FT.map;
h = waitbar(0,'Applying bilateral filter to Layers...');
set(h,'Name','Bilateral Filter Progress');       
for i = 1:nz           
           img = old_map(:,:,i);
           max_val = mval(i);
           new_map(:,:,i) = bilateral_filt(img/max_val,5,[1.5 0.0005])*max_val;
           waitbar(i/nz,h,[num2str(i/nz*100) '%']);
end
close(h);
G_25mT_30mK_B_FT_bfilt.map = new_map;
clear nc nc nz img old_map new_map

old_map = G_25mT_30mK_B_FT_bfilt.map;
new_map = rm_center(old_map,3.5);
G_25mT_30mK_B_FT_bfilt.map = new_map;

clear old_map clear new_map
%%
%%
%% dataset 30614A00
path_root = 'C:\Data\stm data\RUN067\YRS\130614\';
obj_30614A00_G = read_map_no_dialogue('30614A00.2FL', path_root);
obj_30614A00_I = read_map_no_dialogue('30614A00.1FL', path_root);
G_25mT_30mK = current_divide2(obj_30614A00_G,obj_30614A00_I);

[nr nc nz] = size(G_25mT_30mK.map);
% calculate average power in each  real space layer before being
% processed - this sets a more definitive normalization value for bilateral filter      

for i = 1:nz
    mval(i) = abs(mean(mean(G_25mT_30mK.map(:,:,i))))*nr*nc;
end


G_25mT_30mK = polyn_subtract(G_25mT_30mK,2);
G_25mT_30mK_FT = fourier_transform2d(G_25mT_30mK,'none','amplitude','ft');
G_25mT_30mK_FT = symmetrize_image_v2(G_25mT_30mK_FT,'vd');
G_25mT_30mK_FT_bfilt = G_25mT_30mK_FT;
old_map = G_25mT_30mK_FT.map;
h = waitbar(0,'Applying bilateral filter to Layers...');
set(h,'Name','Bilateral Filter Progress');       
for i = 1:nz           
           img = old_map(:,:,i);
           max_val = mval(i);
           new_map(:,:,i) = bilateral_filt(img/max_val,5,[1.5 0.0005])*max_val;
           waitbar(i/nz,h,[num2str(i/nz*100) '%']);
end
close(h);
G_25mT_30mK_FT_bfilt.map = new_map;
clear nc nc nz img old_map new_map

old_map = G_25mT_30mK_FT_bfilt.map;
new_map = rm_center(old_map,3.5);
G_25mT_30mK_FT_bfilt.map = new_map;

clear old_map clear new_map

%%
%% dataset 30701A00
path_root = 'C:\Data\stm data\RUN067\YRS\130616\';
obj_30616A00_G = read_map_no_dialogue('30616A00.2FL', path_root);
obj_30616A00_I = read_map_no_dialogue('30616A00.1FL', path_root);
G_25mT_30mK_B = current_divide2(obj_30616A00_G,obj_30616A00_I);

[nr nc nz] = size(G_25mT_30mK_B.map);
% calculate average power in each  real space layer before being
% processed - this sets a more definitive normalization value for bilateral filter      

for i = 1:nz
    mval(i) = abs(mean(mean(G_25mT_30mK_B.map(:,:,i))))*nr*nc;
end


G_25mT_30mK_B = polyn_subtract(G_25mT_30mK_B,2);
G_25mT_30mK_B_FT = fourier_transform2d(G_25mT_30mK_B,'none','amplitude','ft');
G_25mT_30mK_B_FT = symmetrize_image_v2(G_25mT_30mK_B_FT,'vd');
G_25mT_30mK_B_FT_bfilt = G_25mT_30mK_B_FT;
old_map = G_25mT_30mK_B_FT.map;
h = waitbar(0,'Applying bilateral filter to Layers...');
set(h,'Name','Bilateral Filter Progress');       
for i = 1:nz           
           img = old_map(:,:,i);
           max_val = mval(i);
           new_map(:,:,i) = bilateral_filt(img/max_val,5,[1.5 0.0005])*max_val;
           waitbar(i/nz,h,[num2str(i/nz*100) '%']);
end
close(h);
G_25mT_30mK_B_FT_bfilt.map = new_map;
clear nc nc nz img old_map new_map

old_map = G_25mT_30mK_B_FT_bfilt.map;
new_map = rm_center(old_map,3.5);
G_25mT_30mK_B_FT_bfilt.map = new_map;

clear old_map clear new_map
%%
%% dataset 30701A01
path_root = 'C:\Data\stm data\RUN067\YRS\130701\';
obj_30701A01_G = read_map_no_dialogue('30701A01.2FL', path_root);
obj_30701A01_I = read_map_no_dialogue('30701A01.1FL', path_root);
G_25mT_25mK_B = current_divide2(obj_30701A01_G,obj_30701A01_I);

[nr nc nz] = size(G_25mT_25mK_B.map);
% calculate average power in each  real space layer before being
% processed - this sets a more definitive normalization value for bilateral filter      

for i = 1:nz
    mval(i) = abs(mean(mean(G_25mT_25mK_B.map(:,:,i))))*nr*nc;
end


G_25mT_25mK_B = polyn_subtract(G_25mT_25mK_B,2);
G_25mT_25mK_B_FT = fourier_transform2d(G_25mT_25mK_B,'none','amplitude','ft');
G_25mT_25mK_B_FT = symmetrize_image_v2(G_25mT_25mK_B_FT,'vd');
G_25mT_25mK_B_FT_bfilt = G_25mT_25mK_B_FT;
old_map = G_25mT_25mK_B_FT.map;
h = waitbar(0,'Applying bilateral filter to Layers...');
set(h,'Name','Bilateral Filter Progress');       
for i = 1:nz           
           img = old_map(:,:,i);
           max_val = mval(i);
           new_map(:,:,i) = bilateral_filt(img/max_val,5,[1.5 0.0005])*max_val;
           waitbar(i/nz,h,[num2str(i/nz*100) '%']);
end
close(h);
G_25mT_25mK_B_FT_bfilt.map = new_map;
clear nc nc nz img old_map new_map

old_map = G_25mT_25mK_B_FT_bfilt.map;
new_map = rm_center(old_map,3.5);
G_25mT_25mK_B_FT_bfilt.map = new_map;

clear old_map clear new_map

%% dataset 30703A01
path_root = 'C:\Data\stm data\RUN067\YRS\130703\';
obj_30703A01_G = read_map_no_dialogue('30703A01.2FL', path_root);
obj_30703A01_I = read_map_no_dialogue('30703A01.1FL', path_root);
G_25mT_100mK = current_divide2(obj_30703A01_G,obj_30703A01_I);

[nr nc nz] = size(G_25mT_100mK.map);
% calculate average power in each  real space layer before being
% processed - this sets a more definitive normalization value for bilateral filter      

for i = 1:nz
    mval(i) = abs(mean(mean(G_25mT_100mK.map(:,:,i))))*nr*nc;
end


G_25mT_100mK = polyn_subtract(G_25mT_100mK,2);
G_25mT_100mK_FT = fourier_transform2d(G_25mT_100mK,'none','amplitude','ft');
G_25mT_100mK_FT = symmetrize_image_v2(G_25mT_100mK_FT,'vd');
G_25mT_100mK_FT_bfilt = G_25mT_100mK_FT;
old_map = G_25mT_100mK_FT.map;
h = waitbar(0,'Applying bilateral filter to Layers...');
set(h,'Name','Bilateral Filter Progress');       
for i = 1:nz           
           img = old_map(:,:,i);
           max_val = mval(i);
           new_map(:,:,i) = bilateral_filt(img/max_val,5,[1.5 0.0005])*max_val;
           waitbar(i/nz,h,[num2str(i/nz*100) '%']);
end
close(h);
G_25mT_100mK_FT_bfilt.map = new_map;
clear nc nc nz img old_map new_map

old_map = G_25mT_100mK_FT_bfilt.map;
new_map = rm_center(old_map,3.5);
G_25mT_100mK_FT_bfilt.map = new_map;

clear old_map clear new_map

%%
%% dataset 30705A00
path_root = 'C:\Data\stm data\RUN067\YRS\130705\';
obj_30705A00_G = read_map_no_dialogue('30705A00.2FL', path_root);
obj_30705A00_I = read_map_no_dialogue('30705A00.1FL', path_root);
G_25mT_200mK = current_divide2(obj_30705A00_G,obj_30705A00_I);

[nr nc nz] = size(G_25mT_200mK.map);
% calculate average power in each  real space layer before being
% processed - this sets a more definitive normalization value for bilateral filter      

for i = 1:nz
    mval(i) = abs(mean(mean(G_25mT_200mK.map(:,:,i))))*nr*nc;
end


G_25mT_200mK = polyn_subtract(G_25mT_200mK,2);
G_25mT_200mK_FT = fourier_transform2d(G_25mT_200mK,'none','amplitude','ft');
G_25mT_200mK_FT = symmetrize_image_v2(G_25mT_200mK_FT,'vd');
G_25mT_200mK_FT_bfilt = G_25mT_200mK_FT;
old_map = G_25mT_200mK_FT.map;
h = waitbar(0,'Applying bilateral filter to Layers...');
set(h,'Name','Bilateral Filter Progress');       
for i = 1:nz           
           img = old_map(:,:,i);
           max_val = mval(i);
           new_map(:,:,i) = bilateral_filt(img/max_val,5,[1.5 0.0005])*max_val;
           waitbar(i/nz,h,[num2str(i/nz*100) '%']);
end
close(h);
G_25mT_200mK_FT_bfilt.map = new_map;
clear nc nc nz img old_map new_map

old_map = G_25mT_200mK_FT_bfilt.map;
new_map = rm_center(old_map,3.5);
G_25mT_200mK_FT_bfilt.map = new_map;

clear old_map clear new_map
%%
%% dataset 30707A02
path_root = 'C:\Data\stm data\RUN067\YRS\130707\';
obj_30707A02_G = read_map_no_dialogue('30707A02.2FL', path_root);
obj_30707A02_I = read_map_no_dialogue('30707A02.1FL', path_root);
G_25mT_25mK = current_divide2(obj_30707A02_G,obj_30707A02_I);

[nr nc nz] = size(G_25mT_25mK.map);
% calculate average power in each  real space layer before being
% processed - this sets a more definitive normalization value for bilateral filter      

for i = 1:nz
    mval(i) = abs(mean(mean(G_25mT_25mK.map(:,:,i))))*nr*nc;
end


G_25mT_25mK = polyn_subtract(G_25mT_25mK,2);
G_25mT_25mK_FT = fourier_transform2d(G_25mT_25mK,'none','amplitude','ft');
G_25mT_25mK_FT = symmetrize_image_v2(G_25mT_25mK_FT,'vd');
G_25mT_25mK_FT_bfilt = G_25mT_25mK_FT;
old_map = G_25mT_25mK_FT.map;
h = waitbar(0,'Applying bilateral filter to Layers...');
set(h,'Name','Bilateral Filter Progress');       
for i = 1:nz           
           img = old_map(:,:,i);
           max_val = mval(i);
           new_map(:,:,i) = bilateral_filt(img/max_val,5,[1.5 0.0005])*max_val;
           waitbar(i/nz,h,[num2str(i/nz*100) '%']);
end
close(h);
G_25mT_25mK_FT_bfilt.map = new_map;
clear nc nc nz img old_map new_map

old_map = G_25mT_25mK_FT_bfilt.map;
new_map = rm_center(old_map,3.5);
G_25mT_25mK_FT_bfilt.map = new_map;

clear old_map clear new_map
%%
%% dataset 30709A01
path_root = 'C:\Data\stm data\RUN067\YRS\130709\';
obj_30709A01_G = read_map_no_dialogue('30709A01.2FL', path_root);
obj_30709A01_I = read_map_no_dialogue('30709A01.1FL', path_root);
G_25mT_200mK = current_divide2(obj_30709A01_G,obj_30709A01_I);

[nr nc nz] = size(G_25mT_200mK.map);
% calculate average power in each  real space layer before being
% processed - this sets a more definitive normalization value for bilateral filter      

for i = 1:nz
    mval(i) = abs(mean(mean(G_25mT_200mK.map(:,:,i))))*nr*nc;
end


G_25mT_200mK = polyn_subtract(G_25mT_200mK,2);
G_25mT_200mK_FT = fourier_transform2d(G_25mT_200mK,'none','amplitude','ft');
G_25mT_200mK_FT = symmetrize_image_v2(G_25mT_200mK_FT,'vd');
G_25mT_200mK_FT_bfilt = G_25mT_200mK_FT;
old_map = G_25mT_200mK_FT.map;
h = waitbar(0,'Applying bilateral filter to Layers...');
set(h,'Name','Bilateral Filter Progress');       
for i = 1:nz           
           img = old_map(:,:,i);
           max_val = mval(i);
           new_map(:,:,i) = bilateral_filt(img/max_val,5,[1.5 0.0005])*max_val;
           waitbar(i/nz,h,[num2str(i/nz*100) '%']);
end
close(h);
G_25mT_200mK_FT_bfilt.map = new_map;
clear nc nc nz img old_map new_map

old_map = G_25mT_200mK_FT_bfilt.map;
new_map = rm_center(old_map,3.5);
G_25mT_200mK_FT_bfilt.map = new_map;

clear old_map clear new_map
%%
%% dataset 30711A01
path_root = 'C:\Data\stm data\RUN067\YRS\130711\';
obj_30711A01_G = read_map_no_dialogue('30711A01.2FL', path_root);
obj_30711A01_I = read_map_no_dialogue('30711A01.1FL', path_root);
G_25mT_200mK_B = current_divide2(obj_30711A01_G,obj_30711A01_I);

[nr nc nz] = size(G_25mT_200mK_B.map);
% calculate average power in each  real space layer before being
% processed - this sets a more definitive normalization value for bilateral filter      

for i = 1:nz
    mval(i) = abs(mean(mean(G_25mT_200mK_B.map(:,:,i))))*nr*nc;
end


G_25mT_200mK_B = polyn_subtract(G_25mT_200mK_B,2);
G_25mT_200mK_B_FT = fourier_transform2d(G_25mT_200mK_B,'none','amplitude','ft');
G_25mT_200mK_B_FT = map_rotate(G_25mT_200mK_B_FT,-2);
G_25mT_200mK_B_FT = symmetrize_image_v2(G_25mT_200mK_B_FT,'vd');
G_25mT_200mK_B_FT_bfilt = G_25mT_200mK_B_FT;
old_map = G_25mT_200mK_B_FT.map;
h = waitbar(0,'Applying bilateral filter to Layers...');
set(h,'Name','Bilateral Filter Progress');       
for i = 1:nz           
           img = old_map(:,:,i);
           max_val = mval(i);
           new_map(:,:,i) = bilateral_filt(img/max_val,5,[1.5 0.0005])*max_val;
           waitbar(i/nz,h,[num2str(i/nz*100) '%']);
end
close(h);
G_25mT_200mK_B_FT_bfilt.map = new_map;
clear nc nc nz img old_map new_map

old_map = G_25mT_200mK_B_FT_bfilt.map;
new_map = rm_center(old_map,3.5);
G_25mT_200mK_B_FT_bfilt.map = new_map;

clear old_map clear new_map