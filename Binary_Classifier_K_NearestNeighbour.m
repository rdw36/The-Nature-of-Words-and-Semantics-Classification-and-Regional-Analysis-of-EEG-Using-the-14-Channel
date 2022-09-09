clearvars 
close all

load speech_features.mat
load labels.mat

tic
for x = 1:1000
    array(x, :) = speech_features(x,:);
   
end
    column =  size(speech_features,2);
    array(:, column+1) = labels(:,1);

accuracyHolder = 0;

for t = 1:20
    for j = 1:20
        binIndex = 1;
        
        for x = 1:1000
            if (array(x, size(array,2)) == t) || (array(x, size(array,2)) == j)
                binarySet(binIndex, :) = array(x,:);
                binIndex = binIndex +1;
            end
        end   
        observables = size(binarySet,1);
        indices = crossvalind('Kfold', observables, 5);
        
        %% Training Stage
        
        accuracyHolder = zeros(1,5);

        for i = 1:5
             test = (indices == i)'; 
             train = ~test;

             testInd = binarySet(test,:);
             trainInd = binarySet(train,:);

            xTrain = trainInd;
            yTest = testInd;
            
            
            for x = 1:size(xTrain,1)
                for y= 1:size(xTrain,2)-1
                    trainData(x, y) = xTrain(x,y);  
                end    
            end
            
            trainLabels = zeros(size(xTrain,1),size(xTrain,2));
            trainLabels = xTrain(:, size(xTrain,2));
            
            for x = 1:size(yTest,1)
                for y= 1:size(yTest,2)-1
                    testData(x, y) = yTest(x,y);  
                end    
            end
            
            testLabels = zeros(size(yTest,1),size(yTest,2));
            testLabels = yTest(:, size(yTest,2));
            
            % Supervised training creates a model from the training images
            modelNearestNeighbour = nearestNeighbourTraining(trainData, trainLabels);
        
        %% Testing Stage
        % Loading of labels and images from our dataset, this image will be
        % different from the training images 
        
        % For every image we will infer a label from the model
            for l = 1:size(testData,1)
                
                testNumber = testData(l,:);
                
                classificationResult(l,1) = kNearestNeighbourTesting(testNumber, modelNearestNeighbour, 10);
            end
        
        %% Evaluation Stage
        
        % Predicted classification compared to the correct labelling
            comparison = (testLabels==classificationResult);
            
            % Accuracy measurement for our classification
            accuracyHolder(1,i) = sum(comparison)/length(comparison); 
        end
        accuracy(t,j) = mean(accuracyHolder);
        standardDeviation(t,j) = std(accuracyHolder);
    end
end
average = mean2(accuracy)
averageDeviation= mean2(standardDeviation)

semanticAccuracyColumn = mean(accuracy);
semanticAccuracyRow = mean(accuracy,2);

for i = 1:20
    semanticAccuracy(i,2) = semanticAccuracyColumn(1,i);
    semanticAccuracy(i,1) = semanticAccuracyRow(i,1);
end

semanticFinal = mean(semanticAccuracy,2);

toc
