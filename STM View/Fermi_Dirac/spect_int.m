function spect_int(x,y)
T = 15;
A = x >= 0;
for i = 1:length(x)
    y2(i) = sum((y').*Fermi_Dirac_deriv(x-x(i),T));
end
figure; plot(x,y2/y2(1));
hold on; plot(x,y/y(1),'rx');
yy = thermal_broaden(x,y,T,1);
hold on; plot(x,yy/yy(1),'go');
end