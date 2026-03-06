function ks = KS_statistic(X,F)
% KOLMOGOROV_SMIRNOV Computes the Kolmogorov-Smirnov statistic
% Input:
%   X - Sample of points
%   F - Function handle for the cumulative distribution function (CDF)
% Output:
%   ks - Kolmogorov-Smirnov statistic

N = length(X);

X_sorted = sort(X);
F_sorted = F(X_sorted);

D_plus = max(((1:N) / N) - F_sorted);     % D^+ = max(k/N - F(X_k))
D_minus = max(F_sorted - ((0:N-1) / N));  % D^- = max(F(X_k) - (k-1)/N)

ks = max(D_plus, D_minus);
end
