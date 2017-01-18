function spectrum = dynes_swave(params,E)
a = params(1);
b = params(2);
c = params(3);
d = params(4);




 spectrum=a*real((1+1i*b)./(sqrt((1+1i*b).^2-(c./E).^2)))+d;


end