function[a] = basexp(k,b)
% BASEXP     Base-b expansion of non-negative integer
% INPUTS   : k - expanded number, non-negative (decimal) integer
%            b - expansion base, decimal integer exceeding 1
% OUTPUTS  : a - 1*j array of expansion coefficients, with the
%                most significant coefficient in a(1)
% EXAMPLE  : basexp(0,2) = 0, basexp(1,2) = 1, basexp(2,2) = [1 1]
% SEE ALSO : DEC2BASE
% AUTHOR   : Dimitri Shvorob, dimitri.shvorob@vanderbilt.edu, 6/20/07
%            (Implementation of algorithm on p. 206 of Glasserman (2003))
if k ~= floor(k)||(k < 0)
   error('Input argument "k" must be a non-negative integer')
end
if b ~= floor(b)||(b < 2)
   error('Input argument "b" must be a positive integer exceeding 1')
end
if k
   j = fix(log(k)/log(b)) + 1;
   a = zeros(1,j);
   q = b^(j-1);
   for i = 1:j
       a(i) = floor(k/q);
       k = k - q*a(i);
       q = q/b;
   end
else
   a = 0;
end
