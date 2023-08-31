function labs = bwlabels1(x)
% bwlabels1 labels connected true regions in logical vector
% x is logical vector with connected regions of 1's
% 
% Copyright 2014-2015 The MathWorks, Inc.

% Identify region ends
ends = diff(x) == -1;
ends = [ends; x(end)];
endspos = [0; find(ends)];

idx = reshape(1:length(x), size(x));

% Initialize labels vector
labs = zeros(size(x));

% Iterate over number of regions and label relevant samples
n = sum(ends);
for k = 1:n
    regsel = x & (idx > endspos(k)) & (idx <= endspos(k+1));
    labs(regsel) = k;
end