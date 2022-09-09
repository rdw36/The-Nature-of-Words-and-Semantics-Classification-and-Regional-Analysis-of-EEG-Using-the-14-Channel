function prediction = kNearestNeighbourTesting(testImage,modelNearestNeighbour, K)

% variable declartion, closet array and infinite sized label for adjustment
closest = zeros(K,1);
label = inf;

% array to store results
[rows columns]= size(modelNearestNeighbour.neighbours);
results = zeros(rows,2);

% model1NN.neightbour get each row
for i = 1:rows
    
    % retrieving euclidean distance 
    distanceTest = euclideanDistance(testImage,modelNearestNeighbour.neighbours(i,:));
    label =  modelNearestNeighbour.labels(i);

    % filling of results matrix 
    results(i,1) = distanceTest;
    results(i,2) = label;
end


% sorting of results to select K number
sortedResults = sortrows(results,1);

% selecting of K number
for i = 1:K
    closest(i,1) = sortedResults(i,2);
end

    prediction = mode(closest(:));
end





