function disordered_lattice(n)
x = 1:n;
y = 1:n;

res = 10;
[X,Y] = meshgrid(x,y);

rx = 1:(1/res):n;
ry = 1:(1/res):n;

[RX,RY] = meshgrid(rx,ry);
lattice = zeros(length(rx),length(ry));

%RND_X = 0 + 0.1*randn(n,n);
%RND_Y = 0 + 0.1*randn(n,n);
RND_w = abs(60 + 60.*randn(n,n));
%img_plot2(RND_w);
RND_X = blur(0.0 + 0.012*perlin_noise(zeros(length(rx),length(ry))),50,30);
RND_Y = blur(0.0 + 0.012*perlin_noise(zeros(length(rx),length(ry))),50,30);
for i = 1:n
    for j = 1:n
      %lattice = lattice + Gaussian2D_v2(RX,RY,res/200,[X(i,j)+RND_X(i,j),Y(i,j)+RND_Y(i,j)],1);  
      lattice = lattice + Gaussian2D_v2(RX,RY,res/RND_w(i,j),[X(i,j)+RND_X(i*res-res+1,j*res-res+1),Y(i,j)+RND_Y(i*res-res+1,j*res-res+1)],0.04);  
    end
end
%img_plot2(lattice);
figure; surf(lattice); shading flat;
ft = fourier_transform2d(lattice - mean(mean(lattice)),'none','amplitude','ft');
img_plot2(ft);

amp_noise = perlin_noise(zeros(length(rx),length(ry)));
%amp_noise = peaks(length(rx));
%amp_noise = amp_noise + flipud(amp_noise);
amp_noise = 0.25*amp_noise/max(max(amp_noise));
amp_noise = blur(amp_noise,50,30);
img_plot2(amp_noise);
lattice = lattice + amp_noise;
figure; surf(lattice); shading flat;
ft = fourier_transform2d(lattice - mean(mean(lattice)),'none','amplitude','ft');
img_plot2(ft);
end