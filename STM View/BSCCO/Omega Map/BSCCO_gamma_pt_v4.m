%calculates omega on spectrum on either positive or negative side with
%indexing such energy(1) is the further away from zero bias

function infl_energy =  BSCCO_gamma_pt_v4(y,energy,min_val_ind,peak_val_ind,degree_poly,frac_peak,res)

infl_energy = 0; % error code if no inflection point found

if energy(1) > 0 %postive side spectrum
    x = energy;
else
    x = -1*energy; %negative side spectrum
end

peak_val = y(peak_val_ind);
min_val = y(min_val_ind);
frac_val = (peak_val - min_val)*frac_peak + min_val;
% find set indices which satisfy being larger that frac_val and
% on the right side of the minimum
frac_peak_ind = find( (y>=frac_val)'.*(x<=x(min_val_ind)) == 1,1);
kstart = 1; kend =  frac_peak_ind  ; % for pos side
%figure; plot(x,y); hold on; plot(x(kstart:kend),y(kstart:kend),'r');
count = 0;
col = jet(4);
spc = mean(abs(diff(x))); 
while(count < 12)
    x1 = x(kstart:kend);
    y1 = y(kstart:kend); y1 = y1';
    %figure; plot(x1,y1)
    [p S] = polyfit(x1,y1,degree_poly);
    % generate fine spacing fit
    spc = mean(abs(diff(x1)));
    x_refine = x1(1):-spc/res:x1(end);
    f = polyval(p,x_refine,S);
    %hold on; plot(x_refine,f,'g');
    % calc 2nd derivative from fit to find inflection points
    [df1 dx1] = num_der2b(1,f,x_refine);
    %figure; plot(dx1,df1);
    [df2 dx2] = num_der2b(2,f,x_refine);
    %find the minimum point on the fit
    min_fval_ind = find(f == min(f),1);
    %figure; plot(dx2,df2)
    inflect_index = find_zero_crossing(df2);
    sgn_der_infl_pt = sign(df1(inflect_index));
    inflect_index = inflect_index(sgn_der_infl_pt >=0);
%     for z = 1:length(inflect_index)
%         hold on; plot([dx2(inflect_index(z)) dx2(inflect_index(z))],get(gca,'ylim'));
%     end
    %only select points on the left side of the minimum
    %inflect_index = inflect_index(inflect_index < min_fval_ind);
    % if there is more than one inflection point, truncate the
    % spectrum to get rid of the ones further one in energy
   if length(inflect_index) > 1
        if count <=6
            kstart = round(inflect_index(1)/res) + 1;
            count = count +1;
            % if after a few tries, a single inflection point is not
            % found, add points to the spectrum close to the coherence
            % peak before fitting
        else
            kstart = round(inflect_index(1)/res) + 1;
            % can only go out to coherence peak
            if kend < peak_val_ind
                kend = kend + 1;
                count = 0;
            else
                break;
            end
        end
    elseif length(inflect_index) == 1
        infl_energy = x_refine(inflect_index);
        %hold on; plot([infl_energy infl_energy],get(gca,'ylim'));
        %figure; plot(x,y,'o'); hold on;%figure;
        %plot(x1,y1,'rx'); hold on; plot(x_refine,f,'g'); hold on; plot([infl_energy infl_energy],get(gca,'ylim'));
        break;
    elseif isempty(inflect_index)
        kstart = max(kstart - 1,1);
        count = count+1;
        display('no inflection point found');              
    end
end
% if no fit generates only one inflection point, then just pick the
% one closest to the coherence peak
if length(inflect_index) > 1
    inflect_index = inflect_index(end);
end
if isempty(inflect_index)
    infl_energy = 0;
else
    infl_energy = x_refine(inflect_index);
end
%figure; plot(x,y,'o'); hold on;%figure;
%        plot(x1,y1,'rx'); hold on; plot(x_refine,f,'g'); hold on; plot([infl_energy infl_energy],get(gca,'ylim'));

end
