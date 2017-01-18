function plot_mult_gaussian(n,param,x,offset)
figure; 
Z = 0;
for i = 1:n  
    Z = Z + Gaussian1D_basic(x,[param((1+(i-1)*3):(3+(i-1)*3))]);
    plot(x,Gaussian1D_basic(x,[param((1+(i-1)*3):(3+(i-1)*3))])); hold on;
end
plot(x,Z,'k');
end