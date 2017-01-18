G = G_shear_cor_crop_LFCorrect;
%%
FormFactor = FormFactor_OD70;
x = G.e*1000;
y = G.ave;
%figure; plot(x,y);
dff = [(FormFactor.diff); 1; flipud(FormFactor.diff)];
sff = [(FormFactor.sum); 1;  flipud((FormFactor.sum))]; 
plot_grad_color(dff./(sff + dff),flipud(RedWhiteBlue),x,y)
%% OD70
%energy_OD70 = G.e*1000;
FormFactor = FormFactor_OD70;
gap_OD70 = 28;
dff = [(FormFactor.diff); 1; flipud(FormFactor.diff)];
sff = [(FormFactor.sum); 1;  flipud((FormFactor.sum))]; 
dFF_OD70 = dff./(sff + dff);
figure; plot(energy_OD70,dFF_OD70);
%% OD80
%energy_OD80 = G.e*1000;
FormFactor = FormFactor_OD80;
gap_OD80 = 31.5;
dff = [(FormFactor.diff); 1; flipud(FormFactor.diff)];
sff = [(FormFactor.sum); 1;  flipud((FormFactor.sum))]; 
dFF_OD80 = dff./(sff + dff);
figure; plot(energy_OD80,dFF_OD80);
%% UD65
%energy_UD65 = G.e*1000;
FormFactor = FormFactor_UD65;
gap_UD65 = 48;
dff = [(FormFactor.diff); 1; flipud(FormFactor.diff)];
sff = [(FormFactor.sum); 1;  flipud((FormFactor.sum))]; 
dFF_UD65 = dff./(sff + dff);
figure; plot(energy_UD65,dFF_UD65);
%% UD45
%energy_UD45 = G.e*1000;
FormFactor = FormFactor_UD45;
gap_UD45 = 80;
dff = [(FormFactor.diff); 1; flipud(FormFactor.diff)];
sff = [(FormFactor.sum); 1;  flipud((FormFactor.sum))]; 
dFF_UD45 = dff./(sff + dff);
figure; plot(energy_UD45,dFF_UD45);
%% UD20
%energy_UD20 = G.e*1000;
FormFactor = FormFactor_UD20;
gap_UD20 = 110;
dff = [(FormFactor.diff); 1; flipud(FormFactor.diff)];
sff = [(FormFactor.sum); 1;  flipud((FormFactor.sum))]; 
dFF_UD20 = dff./(sff + dff);
figure; plot(energy_UD20,dFF_UD20);
%%
figure; 
plot(energy_UD20/gap_UD20,dFF_UD20,'k');
xlim ([0.1 1.1]);
hold on;
plot(energy_UD45/gap_UD45,dFF_UD45,'b');
hold on; 
plot(energy_UD65/gap_UD65,dFF_UD65,'g');
hold on; 
plot(energy_OD80/gap_OD80,dFF_OD80,'r');
hold on; 
plot(energy_OD70/gap_OD70,dFF_OD70,'c');
%%
UD20_range = (energy_UD20/gap_UD20) > 0.8 & (energy_UD20/gap_UD20) < 1.2 ;
UD45_range = (energy_UD45/gap_UD45) > 0.8 & (energy_UD45/gap_UD45) < 1.2 ;
UD65_range = (energy_UD65/gap_UD65) > 0.8 & (energy_UD65/gap_UD65) < 1.2 ;
OD80_range = (energy_OD80/gap_OD80) > 0.8 & (energy_OD80/gap_OD80) < 1.2 ;
OD70_range = (energy_OD70/gap_OD70) > 0.8 & (energy_OD70/gap_OD70) < 1.2 ;

UD20_avg = mean(dFF_UD20(UD20_range));
UD45_avg = mean(dFF_UD45(UD45_range));
UD65_avg = mean(dFF_UD65(UD65_range));
OD80_avg = mean(dFF_OD80(OD80_range));
OD70_avg = mean(dFF_OD70(OD70_range));

figure; plot([0.06 0.08 0.1 0.2 0.22], [UD20_avg  UD45_avg UD65_avg OD80_avg OD70_avg])