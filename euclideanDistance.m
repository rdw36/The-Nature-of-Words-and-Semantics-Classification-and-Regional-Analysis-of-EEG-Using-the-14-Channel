function dEuc = EuclideanDistance(sample1,sample2)

% euclidean distance equation
    dEuc = sqrt(sum((sample1-sample2) .^2));

end

