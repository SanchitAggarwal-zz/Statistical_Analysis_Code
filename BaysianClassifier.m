% Course     : Machine Learning Homework Assigment 3
% Description: Bayesian Classifier on MNIST data.
% Author     : Sanchit Aggarwal
% Date       : 3-October-2014
% Copyright (c) 2014 Sanchit Aggarwal. All rights reserved.




%% Read Data
clc;
clear;

load '../Dataset/MNIST_Dataset/mnist_all.mat';
load '../Dataset/MNIST_Dataset/train_labels.mat';
load '../Dataset/MNIST_Dataset/test_labels.mat';

trainData = cat(1, train0, train1, train2, train3, train4, train5, train6, train7, train8, train9);
trainLabel = cat(1, train0_label, train1_label, train2_label, train3_label, train4_label, train5_label, train6_label, train7_label, train8_label, train9_label);
testData = cat(1, test0, test1, test2, test3, test4, test5, test6, test7, test8, test9);
testLabel = cat(1, test0_label, test1_label, test2_label, test3_label, test4_label, test5_label, test6_label, test7_label, test8_label, test9_label);
dimension = 9;

disp(size(testData));
disp(size(testLabel));

%% Bayesian Classifier LDA
[a, T] = directlda(double(trainData), trainLabel, dimension);
[b, T1] = directlda(double(testData), testLabel, dimension);

ldaProjectedTrainData = double(trainData) * (a');
ldaProjectedTestData = double(testData) * (b');

% Fitting the Naive Bayes
NBModel = NaiveBayes.fit(ldaProjectedTrainData, trainLabel);

% Prediction Test Set
cpre = predict(NBModel, ldaProjectedTestData);

% Confusion Matrix and Accuracy
cm = confusionmat(testLabel, cpre);

N = sum(cm(:));
err = ( N-sum(diag(cm)) ) / N;

fprintf('LDA Error %f', err);

%% Bayesian Classifier PCA
load '../Dataset/MNIST_Dataset/mnist_all.mat';
load '../Dataset/MNIST_Dataset/train_labels.mat';
load '../Dataset/MNIST_Dataset/test_labels.mat';

trainData = cat(1, train0, train1, train2, train3, train4, train5, train6, train7, train8, train9);
trainLabel = cat(1, train0_label, train1_label, train2_label, train3_label, train4_label, train5_label, train6_label, train7_label, train8_label, train9_label);
testData = cat(1, test0, test1, test2, test3, test4, test5, test6, test7, test8, test9);
testLabel = cat(1, test0_label, test1_label, test2_label, test3_label, test4_label, test5_label, test6_label, test7_label, test8_label, test9_label);
dimension = 9;

[pcaProjectedTrainData] = pca(trainData, dimension);
[pcaProjectedTestData] = pca(testData, dimension);

% Fitting the Naive Bayes
NBModel = NaiveBayes.fit(double(pcaProjectedTrainData), trainLabel);

% Prediction Test Set
cpre = predict(NBModel, double(pcaProjectedTestData));

% Confusion Matrix and Accuracy
cm = confusionmat(testLabel, cpre);

N = sum(cm(:));
err = ( N-sum(diag(cm)) ) / N;

disp(cm);
fprintf('PCA Error %f', err);
