function n = bwnumregions1(x)
% bwnumregions1 count number of connected true regions in logical vector
% x is logical vector with connected regions of 1's
% 
% Copyright 2014-2015 The MathWorks, Inc.

ends = diff(x) == -1;
ends = [ends; x(end)];
n = sum(ends);