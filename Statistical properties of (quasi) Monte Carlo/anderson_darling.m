function A2 = anderson_darling(X,F)
% ANDERSON_DARLING Computes the Anderson-Darling statistic
% Input:
%   X - Sample of data points
%   F - Function handle for the cumulative distribution function (CDF)
% Output:
%   A^2 - Anderson-Darling test statistic

N = length(X); 

X_sorted = sort(X);
Z = F(X_sorted);

sum_term = sum((2 * (1:N) - 1) .* (log(Z) + log(1 - Z(N + 1 - (1:N)))));

A2 = -N - ((1/N) * sum_term);
end