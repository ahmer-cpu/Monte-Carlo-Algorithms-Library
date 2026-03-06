function U = myfibonacci(size,x_0,x_1, m)
%MYFIBONACCI Generates a psuedorandom Fibonacci sequence 
% Inputs:
%   size - Number of elements of the sequence to generate
%   x_0 - The first seed number
%   x_1 - The second seed number
%   m - The modulus of the generator
% Outputs:
%   U - The Fibonacci sequence of size n scaled to output in (0,1)

a = x_0;
b = x_1;

U = [a/m, b/m ,zeros(1, size-2)];
for i = 1:size-2
    new_val = mod(a+b,m);
    a = b;
    b = new_val;
    if m ~= 0
        U(i+2) = new_val / m;
    else
        U(i+2) = new_val;
    end  
end
end