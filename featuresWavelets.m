%% Import Data and Feature Extraction
clear all

data = csvread('C:\MSc\ICA\vlad_inner_ica.csv', 1, 0);
data(256000, 1:14) = 0;
row = 1;

%% Feature Extraction, features from : : https://uk.mathworks.com/matlabcentral/fileexchange/37950-feature-extraction-using-multisignal-wavelet-transform-decom
for k = 1:256:size(data,1)
    temp = data(k:k+255, :);
    feat = getmswtfeat(temp,50,25,128);
    tempVec = reshape(feat,1,[]);
    vec(row,:) = tempVec;
    row = row + 1;
end


%% Export Data
speech_features = vec;
save('speech_features.mat', 'speech_features')