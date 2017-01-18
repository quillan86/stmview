function y = Fermi_Dirac(energy,T)
kT = T2E_calc(T);
y = [1 + exp(energy/kT)].^-1;
end