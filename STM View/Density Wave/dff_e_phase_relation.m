function [energies, mean_diff, phasestd] = dff_e_phase_relation(data,coordinates,filter_width )

%[nm nn np]=size(data.map);
[nr, nc, nk] = size(data.map);

mask=ones(nr,nc);
n_points=(nk-1)/2;
%n_points = 1;

% x0 = [275 298 66 460];
% y0 = [448 57 182 301];
% 
% mask = zeros(nr,nc);
% w = 30;
% for i = 1:4
%     r_tmp = (y0(i) - w):(y0(i) + w);
%     c_tmp = (x0(i) - w):(x0(i) + w);
%     mask(r_tmp,c_tmp) = 1;    
% end    
% img_plot2(mask);



for i=1:n_points
    
    phase1 = modulation_phase(data,i,coordinates,filter_width);    
    phase2 = modulation_phase(data,nk-i+1,coordinates,filter_width);
    
    [diff_vec1, diffvec2] = phase_difference_vector(phase1,phase2,mask);
    
    diff_vec = vertcat(diff_vec1,diffvec2);
    
    [N,edges] = histcounts(diff_vec);
    
    bin = find(N==max(N));
    bin_centre = mean(edges(bin:bin+1));
    
    if bin_centre >= pi
        
        elements_to_wrap = find(diff_vec < bin_centre-pi);
        wrapping_vec = zeros(size(diff_vec));
        wrapping_vec(elements_to_wrap) = 2*pi;
        wrapped_vec = diff_vec+wrapping_vec;
   
    elseif bin_centre < pi
        elements_to_wrap=find(diff_vec > bin_centre+pi);
        wrapping_vec=zeros(size(diff_vec));
        wrapping_vec(elements_to_wrap)=-2*pi;
        wrapped_vec=diff_vec+wrapping_vec;
        
    end
    
    mean_diff(i) = mean(wrapped_vec);
    phasestd(i) = std(wrapped_vec);
    
    mean_diff  =wrapToPi(mean_diff);

    pi_ratio(i) = length(find(diff_vec >pi/2 & diff_vec < 3*pi/2)) ./ length(diff_vec);
    zero_ratio(i) = 1 - pi_ratio(i);
    
    if mod(i,1)==0
        figure; hist(diff_vec,25) 
        title(['Energy ' num2str(abs(data.e(i)*1000)) ' meV']);
    end    
end

energies = abs(data.e(1:n_points));

figure;  plot(energies, abs(mean_diff)./pi,'ok');
axis square
%xlim([0 0.08])

figure;  plot(energies, pi_ratio,'or',energies,zero_ratio,'ob');

end
