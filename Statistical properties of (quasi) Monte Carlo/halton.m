function halton = halton(size,dim)
%HALTON Generates a Halton sequence
% Inputs:
%   size - Number of elements of the sequence to generate
%   dim - Prime base of the seqence
% Outputs:
%   halton - The Halton sequence of size n and dimension d in the first d
%   prime bases


primes_array = zeros(1, dim);
counter = 0;
num = 2;

while counter < dim
    if isprime(num)  
        counter = counter + 1;
        primes_array(counter) = num;
    end
    num = num + 1;
end

halton = zeros(dim, size);
for b = 1:dim
    halton(b, :) = vdc(size, primes_array(b));
end
end