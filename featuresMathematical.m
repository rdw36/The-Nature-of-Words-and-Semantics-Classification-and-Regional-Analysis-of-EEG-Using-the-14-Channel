%% Convert Data into Vectors
clear all

data = csvread('C:\MSc\ICA\vlad_inner_ica.csv', 1, 0);
data(256000, 1:14) = 0;
row = 1;

for k = 1:256:size(data,1)
    temp = data(k:k+255, :);
    tempVec = reshape(temp,1,[]);
    vec(row,:) = tempVec;
    row = row + 1;
end

%% Feature Extraction, features from : https://uk.mathworks.com/matlabcentral/fileexchange/84235-eeg-feature-extraction-toolbox

for x = 1:size(vec,1)
    y = 1;

    % Kurtosis
    featureVec(x, y)  = jfeeg('kurt', vec(x,:));
    y = y + 1;

    % Skewness
    featureVec(x, y)  = jfeeg('skew', vec(x,:));
    y = y + 1;

    % Median Value
    featureVec(x, y)  = jfeeg('md', vec(x,:));
    y = y + 1;

    % Standard Deviation
    featureVec(x, y)  = jfeeg('sd', vec(x,:));
    y = y + 1;

    % Maximum
    featureVec(x, y)  = jfeeg('max', vec(x,:));
    y = y + 1;

    % Minimum
    featureVec(x, y)  = jfeeg('min', vec(x,:));
    y = y + 1;

    % Sum
    featureVec(x, y)  = sum(vec(x,:));
    
    % Shannon Entropy
    featureVec(x, y)  = jfeeg('sh', vec(x,:));
    y = y + 1;
    
    % First Difference
    featureVec(x, y)  = jfeeg('1d', vec(x,:));
    y = y + 1;
    
    % Further
    % Ratio of Band Power Alpha to Beta
    opts.fs = 128;
    featureVec(x, y)  = jfeeg('rba', vec(x,:), opts);
    y = y + 1;

    % Band Power Gamma
    featureVec(x, y)  = jfeeg('bpg', vec(x,:), opts);
    y = y + 1;

    % Band Power Beta
    featureVec(x, y)  = jfeeg('bpb', vec(x,:), opts);
    y = y + 1;

    % Band Power Alpha
    featureVec(x, y)  = jfeeg('bpa', vec(x,:), opts);
    y = y + 1;

    % Band Power Theta
    featureVec(x, y)  = jfeeg('bpt', vec(x,:), opts);
    y = y + 1;

    % Band Power Delta
    featureVec(x, y)  = jfeeg('bpd', vec(x,:), opts);
    y = y + 1;

    % Hjorth Activity
    featureVec(x, y)  = jfeeg('1d', vec(x,:));
    y = y + 1;

    % 	Normalized First Difference
    featureVec(x, y)  = jfeeg('n1d', vec(x,:));
    y = y + 1;

    % Second Difference
    featureVec(x, y)  = jfeeg('2d', vec(x,:));
    y = y + 1;

    % Normalized Second Difference
    featureVec(x, y)  = jfeeg('n2d', vec(x,:));
    y = y + 1;

    % Mean Curve Length
    featureVec(x, y)  = jfeeg('mcl', vec(x,:));
    y = y + 1;

    % Mean Teager Energy
    featureVec(x, y)  = jfeeg('mte', vec(x,:));
    y = y + 1;

    % Log Root Sum of Sequential Variation
    featureVec(x, y)  = jfeeg('lrssv', vec(x,:));
    y = y + 1;

    % 	Tsallis Entropy
    featureVec(x, y)  = jfeeg('te', vec(x,:));
    y = y + 1;

    % RenyiEntropy
    featureVec(x, y)  = jfeeg('re', vec(x,:));
    y = y + 1;

    % Auto-Regressive Model
    featureVec(x, y:y+3)  =  reshape(jfeeg('ar', vec(x,:)),1,[]);
    y = y + 1;
end

%% Export Data

speech_features = featureVec;
save('speech_features.mat', 'speech_features')

