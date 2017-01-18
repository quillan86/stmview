function [new_dataG,new_dataI] = DOS_conv_map(tip_DOS,tip_e,data)
new_dataG = data;
new_dataI = data;
[nr,nc,nz] = size(data.map);
tmp1 = zeros(nr,nc,nz-2);
tmp2 = zeros(nr,nc,nz);
x = data.e;
for i = 1:nr
    i
    for j = 1:nc
        y = squeeze(data.map(i,j,:));
        [dy,dx,yy,xx] = DOS_conv(y,tip_DOS,x,tip_e);        
        tmp1(i,j,:) = dy;
        tmp2(i,j,:) = yy;
    end
end
new_dataG.e = dx;
new_dataI.e = xx;
new_dataG.map = tmp1;
new_dataG.var = [new_dataG.var 'tipconv'];
new_dataG.ave = avg_map(new_dataG.map);
%new_dataG.tipconv = [tip_DOS tip_e];
new_dataI.map = tmp2;

IMG(new_dataG);
end