function Z = gauss_masking_func_norm(X_list,Y_list,sigma,x,y)

for i = 1:length(X_list)
    A = 2*pi / sigma(i)^2 ; 
    z_array(:,:,i) = A*exp(-((x-X_list(i))^2) / (2*sigma(i)^2))*exp(-((y-Y_list(i))^2) / (2*sigma(i)^2));
end

Z = sum(z_array,3);

end

