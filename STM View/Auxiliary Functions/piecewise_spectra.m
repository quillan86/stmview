function [y_new, varargout] = piecewise_spectra(y,intervals,varargin)

% intervals given in array index, sets of st:end pts (i.e. should be even
% length)

% check to see if there is an energy vector in varargin, if not 
if nargin < 3
    x = 1:length(y);
else
    x = varargin{1};
end

p = intervals;
y_new = [];
x_new = [];
for i = 1:2:length(p/2)-1
    y_new = [y_new; y(p(i):p(i+1))];
    x_new = [x_new x(p(i):p(i+1))];
end
varargout{1} = x_new;
end