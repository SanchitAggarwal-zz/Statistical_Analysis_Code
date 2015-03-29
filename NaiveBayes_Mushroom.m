% Course     : Machine Learning Homework Assigment 3
% Description: Naive Bayes on Mushroom Data.
% Author     : Sanchit Aggarwal
% Date       : 3-October-2014
% Copyright (c) 2014 Sanchit Aggarwal. All rights reserved.


% Reading from csv
data_csv = csvread('../Dataset/Mushroom_Dataset/mushroom_data.csv');

% Reading features
mushroomdataTrain = data_csv(1:4874, :);
mushroomdataTest = data_csv(4875:end, :);

%Train and Test
trainData = mushroomdataTrain(:, 2:end);
trainLabel = mushroomdataTrain(:, 1);

testData = mushroomdataTest(:, 2:end);
testLabel = mushroomdataTest(:, 1);

% Fitting the Naive Bayes
NBModel = NaiveBayes.fit(trainData, trainLabel, 'Distribution', 'mn');

% Prediction Test Set
cpre = predict(NBModel, testData);

% Confusion Matrix and Accuracy
cm = confusionmat(testLabel, cpre);

N = sum(cm(:));
err = ( N-sum(diag(cm)) ) / N;

disp(err);

