function new_data = f_filter_low_pass(data)

if isstruct(data)
    img = data.map;
else
    img = data;
end
[nr nc nz] = size(img);


prompt={'Enter Width of Gaussian for Low Pass Filter'};
name='Low Pass Fourier Filter';
numlines=1;
defaultanswer= {'0'};
answer = inputdlg(prompt,name,numlines,defaultanswer);    
if isempty(answer)
    return;
end
sigma = str2double(answer{1});

if mod(nr,2) == 0
    cr = nr/2 + 0.5;
else 
    cr = nr/2;
end

if mod(nc,2) == 0
    cc = nc/2 + 0.5;
else 
    cc = nc/2;
end
gauss_filt = Gaussian_v2(1:nr,1:nc,sigma,sigma,0,[cr cc],1);

for k = 1:nz
    new_img(:,:,k) = gauss_filt.*img(:,:,k);
end

if isstruct(data)
    new_data = data;
    new_data.map = new_img;
    new_data.var = [new_data.var '_Low_pass_filt_'];
    new_data.ops{end+1} = ['Low pass fourier filter with width (in pixels) ' answer{1}];
    IMG(new_data);   
else
    new_data = new_img;
    img_plot2(new_data,get_color_map('Blue2'),'Low Pass Filter');
end

end