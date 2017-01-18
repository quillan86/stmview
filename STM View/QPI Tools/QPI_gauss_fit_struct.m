function new_struct = QPI_gauss_fit_struct (fit_struct,lyr,p_init,p_fit,window,varargin)
new_struct = [];
%varargin{1}:inititalize flag - initialize sturcture for the first time
%varargin{2}: line cut structure

% if initialize flag on then create new fit_structure
if nargin > 5
    new_struct.cut = varargin{2};    
    new_struct.p_init = [];
    new_struct.p_fit = [];
    new_struct.window = [];
    new_struct.n_gauss = [];
end

% if there is already information in fit_struct then alter it 
if ~isempty(fit_struct)
    new_struct = fit_struct;
    % user sets lyr to 0 if they are initializing the structure elements
    % completely
    if lyr == 0 
        new_struct.p_init = p_init;
        new_struct.p_fit = p_fit;
        new_struct.window = window;        
        
    % if an actual layer is specified adjust the layer 
    elseif lyr > 0     
        new_struct.p_init(lyr,:) = 0;
        new_struct.p_fit(lyr,:) = 0;
        new_struct.window(lyr,:) = 0;
        
        sz = size(p_init,2);
        new_struct.n_gauss(lyr) = floor(sz/3);
        
        new_struct.p_init(lyr,1:sz-1) = p_init(1:end-1);
        new_struct.p_init(lyr,end) = p_init(end);
        
        new_struct.p_fit(lyr,1:sz-1) = p_fit(1:end-1);
        new_struct.p_fit(lyr,end) = p_fit(end);
        
        new_struct.win(lyr,:) = window;
    end
else
    return;
end

end