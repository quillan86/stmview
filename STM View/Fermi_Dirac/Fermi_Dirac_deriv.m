function dyde = Fermi_Dirac_deriv(energy,T)
% chemical potential = 0;
% energy in meV
kT = T2E_calc(T); % Kelvin T to meV
%dyde = (exp(energy/kT))./(((exp(energy/kT) + 1).^2)*kT);
dyde = -1./(4*kT*(cosh(energy/(2*kT)).^2));
end