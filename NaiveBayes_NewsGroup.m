% Course     : Machine Learning Homework Assigment 3
% Description: Naive Bayes on News Group Data.
% Author     : Sanchit Aggarwal
% Date       : 3-October-2014
% Copyright (c) 2014 Sanchit Aggarwal. All rights reserved.

load '../Dataset/20news-bydate/tfidf_knn_test.mat';
trainData = tfidf;
trainData(isnan(trainData)) = 0;

load '../Dataset/20news-bydate/tfidf_knn_train.mat';
testData = tfidf;
testData(isnan(testData)) = 0;

load '../Dataset/20news-bydate/data500.mat';


trainLabel = labelTrain;
testLabel = labelTest;

% Fitting the Naive Bayes
NBModel = NaiveBayes.fit(trainData, trainLabel, 'Distribution', 'mn');

% Prediction Test Set
cpre = predict(NBModel, testData);

% Confusion Matrix and Accuracy
cm = confusionmat(testLabel, cpre);

N = sum(cm(:));
err = ( N-sum(diag(cm)) ) / N;

disp(err);

