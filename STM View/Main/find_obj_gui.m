function obj_gui = find_obj_gui(f)
% find all open figures
h = evalin('base','findobj(''type'',''figure'')');
% separate out all ones which have a structure element in their guidata
% that makes them data image objects
count = 0;
obj_gui = [];
for i = 1:length(h)
    %if isstruct(guidata(h(i))) && h(i) ~= f
    if isfield(guidata(h(i)),'map') && h(i) ~= f
        count = count + 1;
        obj_gui(count) = h(i);     
    end
end
end