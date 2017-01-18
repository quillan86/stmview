function diff = dynes_dwave_diff(params,E,spectrum)
a = params(1);
b = params(2);
c = params(3);
d = params(4);

N = 1000;
theta = linspace(0,pi/4,N);
L = length(E);
diff = zeros(1,L);
for i = 1:L
    diff(i)=a*real(sum((1+1i*b)./(sqrt((1+1i*b).^2-((c/E(i)).*cos(2*theta)).^2)))/N)+d-spectrum(i);
end

end