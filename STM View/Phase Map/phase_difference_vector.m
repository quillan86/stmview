function [diff_vec1,diff_vec2] = phase_difference_vector(phase1,phase2,mask)

phase_diff1 = phase1.theta1-phase2.theta1;
phase_diff1(mask==0) = NaN;
diff_vec1 = phase_diff1(:);
diff_vec1(isnan(diff_vec1)) = [];
diff_vec1 = wrapTo2Pi(diff_vec1);

phase_diff2 = phase1.theta2-phase2.theta2;
phase_diff2(mask==0) = NaN;
diff_vec2 = phase_diff2(:);
diff_vec2(isnan(diff_vec2)) = [];
diff_vec2 = wrapTo2Pi(diff_vec2);

end
