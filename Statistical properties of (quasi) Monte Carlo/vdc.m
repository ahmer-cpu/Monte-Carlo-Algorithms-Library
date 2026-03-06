function vdc_sequence = vdc(size,base)
%VDC Generates a Van der Corput sequence
% Inputs:
%   size - Number of elements of the sequence to generate
%   base - Prime base of the seqence
% Outputs:
%   vdc_sequence - The Van der Corput sequence of size n and base b

vdc_sequence = zeros(1,size);
for i = 1:size
    base_exp = basexp(i,base);
    k = length(base_exp);
    vdc = 0;
    for j = 0:k-1
        vdc = vdc + (base_exp(k-(j)) / (base^(j+1)));
    end
    vdc_sequence(i) = vdc;
end