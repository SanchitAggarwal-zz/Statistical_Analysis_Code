% Course     : Machine Learning Homework Assigment 3
% Description: KNN on News Group Data.
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

accuracy = [];
i = 1;
for k = 1:15
    class = knnclassify(testData, trainData, labelTrain, k)
    cm = confusionmat(labelTest, class)
    N = sum(cm(:));
    err = ( N-sum(diag(cm)) ) / N;
    accuracy(k) = (1 - err)*100;
end

k=[1 2 3 4 5 6 7 8 9 10 11 12 13 14 15];
plot(k, accuracy)