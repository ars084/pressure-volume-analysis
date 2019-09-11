function [out] = btw(x,range)
% This code tells you the points in a range
% It outputs a vector of 0 (for not in range) and 1 (for in range)
out = zeros(1,length(x));
for i = 1:length(x)
    if x(i) > range(1) && x(i) < range(2)
        out(i) = 1;
    else
        out(i) = 0;
    end
end
end