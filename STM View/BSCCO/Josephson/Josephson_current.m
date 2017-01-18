function [Ic_pos Vc_pos] = Josephson_current(x,y)
y_max = min(y);
Ic_pos = y_max;
Vc_pos = x(y == y_max);
Vc_pos = Vc_pos(1);
end