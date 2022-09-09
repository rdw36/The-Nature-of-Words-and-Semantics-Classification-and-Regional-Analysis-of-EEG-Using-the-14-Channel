%% Convert data into vectors
clear all

data = csvread('C:\MSc\ICA\1_inner_ica.csv', 1, 0);
data(256000, 1:14) = 0;
row = 1;

for k = 1:256:size(data,1)
    temp = data(k:k+255, :);
    tempVec = reshape(temp,1,[]);
    vec(row,:) = tempVec;
    row = row + 1;
end

%% Feature extraction Driven By MATLAB Functions
windowLength = round(0.05*128);
overlapLength = round(0.025*128);

for i = 1:1000
    S = stft(vec(i,:),"Window",hann(windowLength,"periodic"),"OverlapLength",overlapLength,"FrequencyRange","onesided");
    S = abs(S);
    filterBank = designAuditoryFilterBank(128,'FFTLength',windowLength);
    melSpec = filterBank*S;
    melcc = cepstralCoefficients(melSpec);
    mfccFeatures(i,:) = reshape(melcc,1,[]);
end

%% Export Data
speech_features = mfccFeatures;
save('speech_features.mat', 'speech_features')
