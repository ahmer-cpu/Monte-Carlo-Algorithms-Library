function seed = generate_seed(size, method)
% GENERATE_SEED Generates a seed array using 'mt' (Mersenne Twister) or 'lcg' (Linear Congruential Generator)
% Inputs:
%   size - Number of seed values to generate
%   method - 'mt' for Mersenne Twister, 'lcg' for Linear Congruential Generator
% Output:
%   seed - Generated seed array of length 'size'

m = 2^31;

if strcmp(method, 'mt')
    seed = floor(rand(1, size) * m);
    
elseif strcmp(method, 'lcg')
    % Standard LCG
    X0 = randi([0, m-1]); % Random initial seed
    a = 1664525;          % Standard multiplier
    c = 1013904223;       % Increment
    seed = zeros(1, size);
    seed(1) = X0;

    for i = 2:size
        seed(i) = mod(a * seed(i-1) + c, m);
    end
else
    error('Invalid method. Use ''mt'' for Mersenne Twister or ''lcg'' for Linear Congruential Generator.');
end

end