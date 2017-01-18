G = G_shear_cor_crop_LFCorrect;
%%
x = G.e*1000;
y = G.ave;
%figure; plot(x,y);
dff = [(FormFactor.diff); 1; flipud(FormFactor.diff)];
sff = [(FormFactor.sum); 1;  flipud((FormFactor.sum))]; 
plot_grad_color(dff./(sff + dff),flipud(RedWhiteBlue),x,y)