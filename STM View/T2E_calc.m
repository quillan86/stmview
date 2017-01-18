%%%%%
% Converts temperature scale to meV scale
%%%%%
function energy = T2E_calc(temperature)
kB = 1.3806503*(10^-23); %Boltzmann Constant
J = 6.24150974*(10^21); %milli electron volts / Joule
energy = kB*J*temperature;
end