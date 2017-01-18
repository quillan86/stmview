%%%%%%%
% CODE DESCRIPTION:  Sometimes non-pixel values of coordinates array are
% needed for finer location of peaks in data.  This code accepts non-array
% values and interpolates from the values of the array_coord variable
% e.g. coord_array = [10 20 30 40], non_array_val = 3.5, then output is 35
%
% INPUT:  coord_array - contains the discrete coordinates values
%         non_array_val - non-integer array index to be found
%
% OUTPUT: coord - interpolated coordinate
%
% CODE HISTORY
%
%150606 MHH  Created
%%%%%%%%

function coord = interp_coord(coord_array,non_array_val)
r = coord_array;
val = non_array_val;
coord = zeros(size(val,1),size(val,2));
for i = 1:size(val,1)
    for j = 1:size(val,2)
        coord(i,j) = interp1(1:length(r),r,val(i,j));
    end
end

end