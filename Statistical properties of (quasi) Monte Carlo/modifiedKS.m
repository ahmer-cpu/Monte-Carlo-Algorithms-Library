function modKS = modifiedKS(KS,n)
%MODIFIEDKS Returns the Modifed Kolmogorov-Smirnov Statistic
%   Takes in as input the regular KS and n, and returns the modified KS
modKS = KS*(sqrt(n) + 0.12 + (0.11/sqrt(n)));
end

