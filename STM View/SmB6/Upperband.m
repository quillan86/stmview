% calculate min(Ek+)
function y = Upperband(v,ef)
y = (-1600+ef)./2 + sqrt(((-1600-ef)./2).^2+v.^2);
