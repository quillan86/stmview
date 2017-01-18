function const_g_egap(data,type,e_interval,res)
g_data = data;
[nr, nc, nz] = size(data.map);
e = data.e*1000;
zero_e = find(e == 0);
e_vec = find(e >= e_interval(1) & e <=e_interval(2));
zero_e = find(e(e_vec) == 0);
g_data.e = data.e(e_vec);
tmp = zeros(nr,nc,length(e_vec));
for i = 1:length(e_vec)
    tmp(:,:,i) = data.map(:,:,i-1+e_vec(1));
end
g_data.map = tmp;
g_data.ave = squeeze(squeeze(mean(mean(g_data.map))));
%IMG(g_data);

g_vals = 0.001:res:1;
%g_vals = min(g_data.ave):res:min(g_data.ave(1),g_data.ave(end));

%figure; plot(g_data.e,g_data.ave,'b-',[-0.01 0.01],[g_vals(2) g_vals(2)]);
x = g_data.e*1000;
dd = x(1) - x(2);
x_fine = x(1):-dd/10:x(end);
gg_pos = zeros(nr,nc,length(g_vals));
gg_neg = zeros(nr,nc,length(g_vals));
for i = 1:nr
    i
    for j = 1:nc
        y = squeeze(squeeze(g_data.map(i,j,:)));
        %y = y - min(y);
        p = polyfit(x,y',4);
        f = polyval(p,x_fine);
        for k =  1:length(g_vals)
            LineValue = g_vals(k);
            idx = find(diff(f >= LineValue));
            x2 = x_fine(idx) + (LineValue - f(idx)) .* (x_fine(idx+1) - x_fine(idx)) ./ (f(idx+1) - f(idx));                       
            if length(x2) == 2                  
                gg_pos(i,j,k) = x2(2);
                gg_neg(i,j,k) = x2(1);
            elseif length(x2) == 1
                if x2 <= 0
                    gg_neg(i,j,k) = x2(1);
                else
                    gg_pos(i,j,k) = x2;
                end
            end
            %figure; plot(x_fine,f,'b-'); hold on; plot(x,y,'k');
            %hold on; plot([-20 20],[g_vals(k) g_vals(k)],'r');
            %hold on; plot(x2,[g_vals(k) g_vals(k)],'ro'); 
        end        
    end
end


g_pos = data;
g_pos.e = g_vals;
g_pos.map = gg_pos;
g_pos.var = 'gvar_map_pos';
g_neg = data;
g_neg.e = g_vals;
g_neg.map = gg_neg;
g_neg.var = 'gvar_map_neg';

IMG(g_pos);
IMG(g_neg);
end