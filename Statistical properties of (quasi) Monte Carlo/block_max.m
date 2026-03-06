function max_vals = block_max(X, t)
% BLOCK_MAX_GENERAL Computes max values in blocks of size t (for vectors)
% or max across columns (for matrices).
%
% Inputs:
%   X - Input vector or matrix
%   t - Block size (for vectors only, ignored for matrices)
% Output:
%   max_vals - Max values per block (vector case) or per column (matrix case)

if isvector(X)  % Case 1: X is a vector
    N = length(X);
    num_blocks = ceil(N / t);
    max_vals = arrayfun(@(i) max(X(((i-1)*t+1):min(i*t, N))), 1:num_blocks);

elseif ismatrix(X)  % Case 2: X is a matrix (treat each column separately)
    % Note that this makes t = k where k is the column length
    % This implicilty assumes that k=t for the Max test
    max_vals = max(X, [], 1);

else
    error('Input must be a vector or matrix');
end
end
