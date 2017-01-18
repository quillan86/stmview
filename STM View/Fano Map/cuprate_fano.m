function cuprate_fano(data,gap,init_guess,name)

%nr = 20;
%nc = 20;
map = data.map;
x = data.e;
[nr, nc, nz] = size(map);
fano_a = zeros(nr,nc);
fano_b = zeros(nr,nc);
fano_c = zeros(nr,nc);
fano_d = zeros(nr,nc);
fano_e = zeros(nr,nc);
fano_g = zeros(nr,nc);
fano_q = zeros(nr,nc);
%fano_gof = zeros(nr,nc);

dgap_index = index_val_map(gap,x);
dgap_index_neg = index_val_map(-gap,x);

x = x*1000;
for i = 1:nr
    i
    Y = squeeze(map(i,:,:));   
    parfor j = 1:nc
        ss = fitoptions('Method','NonlinearLeastSquares',...
        'Startpoint',init_guess,...
        'Algorithm','Levenberg-Marquardt',...
        'TolX',1e-5,...
        'MaxIter',5000,...
        'MaxFunEvals', 5000);
        y = squeeze(Y(j,:));
        
        gap_val_index = dgap_index(i,j);
        if gap_val_index == 0
            gap_val_index = 1;
        end
        pt1 = max(gap_val_index-25,1);  

        gap_val_index  = dgap_index_neg(i,j);
        if gap_val_index == 0
            gap_val_index = nz;
        end
        pt4 = min(gap_val_index);

        pp = [pt1 85 114 pt4];
        [y_new, x_new] = piecewise_spectra(y',pp,x);      
        [param,gof] = fano_fit3(x_new',y_new,ss);
        %display('here');
       % display([num2str(i) ',' num2str(j)])
        fano_a(i,j) = param.a;
        fano_b(i,j) = param.b;
        fano_c(i,j) = param.c;
        fano_d(i,j) = param.d;
        fano_e(i,j) = param.e;
        fano_g(i,j) = param.g;
        fano_q(i,j) = param.q;
       % fano_gof(i,j) = gof;
    end
end
fano.a = fano_a;
fano.b = fano_b;
fano.c = fano_c;
fano.d = fano_d;
fano.e = fano_e;
fano.g = fano_g;
fano.q = fano_q;
%fano.gof = fano_gof;
assignin('base',[name 'fano'],fano);
save('c:\Users\Mohammad Hamidian\Documents\Research\Data Analysis\BSSCO\70809240 v2 - UD20\Fano_vars.mat','fano')
end