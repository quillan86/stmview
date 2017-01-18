p_lattice = sin(phase_map.s_phase1) + sin(phase_map.s_phase2); 
img_plot2(p_lattice);
p_lattice = sin(phase_map.s_phase1) + sin(phase_map.s_phase2 + pi); 
img_plot2(p_lattice);
%% recreates original Topo without shear correction
p_lattice = sin(phase_map.s_phase1 + phase_map.theta1 + pi) + sin(phase_map.s_phase2 + phase_map.theta2 + pi); 
img_plot2(p_lattice);
%% recreates LF corrected topo
p_lattice = sin(phase_map.s_phase1+ pi/2) + sin(phase_map.s_phase2+ pi/2); 
img_plot2(p_lattice);
%% 
clear A B C;
% begin with LF corrected topo phase
s_phase1 = phase_map.s_phase1 + pi/2; s_phase2 = phase_map.s_phase2 + pi/2;
%img_plot2(s_phase1); img_plot2(s_phase2);

% shift the phase maps so that they are all positive definite
min_s1 = min(min(s_phase1)); min_s2 = min(min(s_phase2));
offset1 = abs(min_s1 - rem(min_s1,2*pi)) + 2*pi;
offset2 = abs(min_s2 - rem(min_s2,2*pi)) + 2*pi;
s_phase1 = s_phase1 + (offset1);
s_phase2 = s_phase2 + (offset2);


int2 = (s_phase2- rem(s_phase2,2*pi))/(2*pi);
int1 = (s_phase1- rem(s_phase1,2*pi))/(2*pi);

int1 = round(int1);
int2 = round(int2);
img_plot2(int1); img_plot2(int2);
%%
clear C;
N1 = round(max(max(int1)));
n1 = round(min(min(int1)));
N2 = round(max(max(int2)));
n2 = round(min(min(int2)));
A = zeros(200,200);
for i = n1:N1
    for j = n2:N2
        B = (int1 == i) & (int2 == j);
        if (sum(sum(B))) ~= 0
            pB = p_lattice.*B;
            %img_plot2(pB);
            C = (pB > 0) &(pB == max(max(pB)));
            A = A + C;
        end
    end
end
A(1:2,:) = 0;
A(end-1:end,:) = 0;
A(:,1:2) = 0;
A(:,end-1:end) = 0;
img_plot2(A)
