function [xdata, ydata] = get_graph_data(fig_handle)

h = fig_handle;
axesObjs = get(h, 'Children');  %axes handles
dataObjs = get(axesObjs, 'Children');

xdata = get(dataObjs, 'XData');  %data from low-level grahics objects
ydata = get(dataObjs, 'YData');

figure; plot(xdata,ydata);

end