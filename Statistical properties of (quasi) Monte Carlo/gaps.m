function [gaps, P] = gaps(X,alpha,beta,t)
%GAPS Computes the gaps in the sequence for the Gap Test
% Inputs:
%   X - Sequence to compute gaps on
%   alpha, beta - Define the interval J = (alpha, beta)
%   t - Largest gap to count (t or more truncation)
% Output:
%   gaps - An array of frequency of gaps uptil t-1 and then t or more
%   P - Probability values for the distribution of gaps (theoretical)

gaps = zeros(1,t+1);
P = zeros(1,t+1);
p = abs(beta-alpha);
for i = 0:t-1
    P(i+1) = p*((1-p)^(i));
end
P(t+1) = (1-p)^t;

i = 1;
while (i < length(X))
    counter = 0;
    j = i;
    while (X(j) > beta) || (X(j) < alpha)
        counter = counter + 1;
        j = j+1;
        if(j > length(X))
            break;
        end
    end
    if(counter >= t)
        gaps(t+1) = gaps(t+1) + 1;
    else
        gaps(counter+1) = gaps(counter+1) + 1;
    end
    i = i+counter+1;
end