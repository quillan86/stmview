function patch_lattice(n)

max_length = 10;
min_length = 6;
count = 0;
A = zeros(n,n);
B = (A~=0);
while (sum(sum(B))) < 0.65*(n^2)
    sum(sum(B))
    rnd_coord = randi(10,2,1);
    rnd_x_len = randi([min_length,max_length],1,1);
        rnd_y_len = randi([min_length,max_length],1,1);
    if A(rnd_coord) == 0
        count = count + 1;
        rnd_x_len = randi([min_length,max_length],1,1);
        rnd_y_len = randi([min_length,max_length],1,1);
        x_coord = rnd_coord(2) + rnd_x_len;
        y_coord = rnd_coord(1) + rnd_y_len;
        A(rnd_coord(2):rnd_coord(2) + rnd_y_len,rnd_coord(1):rnd_coord(1) + rnd_x_len) = count;
    end    
    B = (A~=0);
    sum(sum(B))
end
img_plot2(A);
end