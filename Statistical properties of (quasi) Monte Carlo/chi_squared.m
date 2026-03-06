function Q = chi_squared(Y, p, n)
% CHI_SQUARED Computes the chi-squared statistic
% Inputs:
%   Y - Vector of observed event counts (Y_i)
%   p - Vector of true probabilities (p_i) (should sum to 1)
%   n - Total sample size
% Output:
%   Q - Chi-squared test statistic

E = n * p;
Q = sum((Y - E).^2 ./ E);
end