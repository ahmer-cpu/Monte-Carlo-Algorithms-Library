function U = lagged_fibonacci(size, seed, k1, k2, m)
% LAGGED_FIBONACCI Generates a sequence using the Lagged Fibonacci Generator
% Inputs:
%   size - Number of numbers to generate
%   seed - Initial seed array of length max(k1, k2)
%   k1, k2 - Lags (k1 > k2)
%   m - The modulus of the generator
% Outputs:
%   U - The Lagged Fibonacci sequence of size n scaled to output in (0,1)

if k1 <= k2
    error('k1 must be greater than k2');
end
if length(seed) < k1
    error('Seed array must be at least of length k1');
end

state = seed;  
U = zeros(1, size);

for i = 1:size
    new_val = mod(state(end-k1+1) + state(end-k2+1), m);
    
    U(i) = new_val / m;
    
    state = [state(2:end), new_val];
end
end