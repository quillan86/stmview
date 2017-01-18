function new_data = piecewise_map(data,intervals)
[nr, nc, nz] = size(data.map);

%new_map = zeros(nr,nc,);
new_data = data;
new_data.map = [];
new_data.e = piecewise_spectra(data.e',intervals);
new_data.e = new_data.e';

for i = 1:nr
    for j = 1:nc
         y = squeeze(squeeze(data.map(i,j,:)));
         y_new = piecewise_spectra(y,intervals);
         new_map(i,j,:) = y_new;
          %figure; plot(y); hold on; plot(squeeze(squeeze(new_map(i,j,:))),'rx');
    end
end
new_data.map = new_map;
new_data.ops{end+1} = ['piecewise cut from intervals [' num2str(intervals) ' ]'];
new_data.var = [new_data.var '_pccut'];
end

