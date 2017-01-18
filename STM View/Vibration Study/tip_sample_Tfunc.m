function [Z,w] = tip_sample_Tfunc(n,M,W,C)
w = logspace(-1,4.3,5000);
Y = 1;
%w = 1;
K = W.^2.*M;

for i = 1:length(w)
    A = zeros(n,n);
    B = zeros(n,n);
    P = zeros(1,n);
    
    A(1,1) = K(1)+K(2)-M(1)*w(i)^2;
    A(1,2) = -K(2);    
    A(n,n-1) = -K(n);
    A(n,n) = K(n)-M(n)*w(i)^2;
    
    B(1,1) = C(1)+C(2);
    B(1,2) = -C(2);
    B(n,n-1) = -C(n);
    B(n,n) = C(n);
        
    P(1) = (K(1) + 1i*w(i)*C(1))*Y;
   
    for j = 2:n-1
        A(j,j-1) = -K(j);
        A(j,j) = K(j) + K(j+1) - M(j)*w(i)^2;
        A(j,j+1) = -K(j+1);
        
        B(j,j-1) = -C(j);
        B(j,j) = C(j) + C(j+1);
        B(j,j+1) = -C(j+1);        
    end   
    D = A + 1i*w(i)*B;
    X = inv(D)*P';
    Z(i) = (real(X(n)-X(n-1)).^2 + imag(X(n)-X(n-1)).^2)^0.5/Y;
end
%figure;semilogx(w,mag2db(Z))
end