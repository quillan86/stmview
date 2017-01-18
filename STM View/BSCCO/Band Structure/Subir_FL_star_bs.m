function [E_pos, E_neg] = Subir_FL_star_bs(t1,t2,t3,u,s0,s1,lambda)
kx = -pi:0.01:pi;
ky = kx;
[KX, KY] = meshgrid(kx,ky);

qx = pi;
qy = pi;

%figure; mesh(KX,KY,xi_pos(0,0));
%colormap(get_color_map('Defect1'));
%axis equal;

E_pos = (xi_pos(0,0) + xi_neg(qx,qy))/2 + sqrt(((xi_pos(0,0) - xi_neg(qx,qy))/2).^2 + lambda^2);
E_neg = (xi_pos(0,0) + xi_neg(qx,qy))/2 - sqrt(((xi_pos(0,0) - xi_neg(qx,qy))/2).^2 + lambda^2);

n_c = -0.5:0.02:0.5;
figure; contour(KX,KY,E_pos,n_c);
hold on; contour(KX,KY,E_neg,n_c);
colormap(get_color_map('jet'));
axis equal;

    %nested function for xi+ and xi-
    function y = xi_pos(QX,QY)
        y = e_k(t1,t2,t3,u,KX,KY,QX,QY) + f_k(s0,s1,KX,KY,QX,QY);
    end
    function y = xi_neg(QX,QY)
        y = e_k(t1,t2,t3,u,KX,KY,QX,QY) - f_k(s0,s1,KX,KY,QX,QY);
    end
end
% subfunction to generate epsilon functions
function y = e_k(t1,t2,t3,u,KX,KY,QX,QY)
KX_Q = KX + QX; KY_Q = KY + QY;
y = -2*t1*(cos(KX_Q) + cos(KY_Q)) - 4*t2*cos(KX_Q).*cos(KY_Q) -...
            2*t3*(cos(2*KX_Q)+2*cos(2*KY_Q)) - u;
end
function y = f_k(s0,s1,KX,KY,QX,QY)
KX_Q = KX + QX; KY_Q = KY + QY;
y = -s0 - s1*(cos(KX_Q) + cos(KY_Q));
end