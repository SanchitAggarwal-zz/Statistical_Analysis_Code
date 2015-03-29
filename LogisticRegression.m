% Course     : Machine Learning Homework Assigment 4
% Description: Logistic Regression on MNIST data.
% Author     : Sanchit Aggarwal
% Date       : 16-October-2014
% Copyright (c) 2014 Sanchit Aggarwal. All rights reserved.

%% Read Data
function [Accuracy,Voting,ClassifierAccuracy] = HW4_LogisticRegression%(pair1,pair2)
    clc;
    clear;
    % load data
    load '../Dataset/MNIST_Dataset/mnist.mat'; % stuct 'data' with training and testing data
    load '../Dataset/MNIST_Dataset/mnist_all.mat'
    K=0;
    Accuracy = zeros(45,3);
    testingData = cat(1, test0,test1,test2,test3,test4,test5,test6,test7,test8,test9);
    testingLabel = cat(1, 1*ones(size(test0,1),1),...
                          2*ones(size(test1,1),1),...
                          3*ones(size(test2,1),1),...
                          4*ones(size(test3,1),1),...
                          5*ones(size(test4,1),1),...
                          6*ones(size(test5,1),1),...
                          7*ones(size(test6,1),1),...
                          8*ones(size(test7,1),1),...
                          9*ones(size(test8,1),1),...
                          10*ones(size(test9,1),1));
    Voting = zeros(size(testingData,1),10);
    
    %H = figure;
    for i = 1:10
        for j = i+1:10
            K = K + 1;
            pair = ['Pair_Train' int2str(i-1) '_Train' int2str(j-1)];
            pair1 = data(1,i).training;
            pair2 = data(1,j).training;
            N1 = size(pair1,1);
            N2 = size(pair2,1);
            trainData = cat(1, pair1, pair2);
            trainLabel = cat(1, ones(N1,1), zeros(N2,1));
            trainData = trainData/(255-min(min(trainData)));
            %     % logistic regression model
            %     [B,dev,stats] = mnrfit(double(trainData),double(trainLabel));
            [W] = LogisticRegression(trainData,trainLabel);
            
            WeightImage = reshape(W(1,2:end),28,28)';
            H = figure;
            subplot(1,1,1),subimage(WeightImage);
            title(['Pair Train ' int2str(i-1) ' vs Train ' int2str(j-1)]);
            saveas(H,['../Results/HW4/' pair '.jpg']);
            
            pair1 = data(1,i).testing;
            pair2 = data(1,j).testing;
            N1 = size(pair1,1);
            N2 = size(pair2,1);
            testData = cat(1, pair1, pair2);
            testLabel = cat(1, ones(N1,1), zeros(N2,1));
            testData = testData/(255-min(min(testData)));
            [Y1,T] = classify(testData,W);
            Error = testLabel-Y1;
            Accuracy(K,1) = i;
            Accuracy(K,2) = j;
            Accuracy(K,3) = sum(Error == 0)*100/size(Y1,1);
            % Voting
            [Y] = classify(testingData,W);
            Voting(Y==1,i) = Voting(Y==1,i) + 1; %i is postive class for the current pair
            Voting(Y==0,j) = Voting(Y==0,j) + 1;
        end
    end
    [Vote,PredictedLabel] = max(Voting,[],2);
    Error = testingLabel-PredictedLabel;
    ClassifierAccuracy = sum(Error == 0)*100/size(PredictedLabel,1);
end

function [Y,T] = classify(data,W)
    N = size(data,1);
    D = size(data,2);
    X = double(cat(2,ones(N,1),data));
    T = W*X';
    Y = sigmoid(T);
    Y(Y>=0.5) = 1;
    Y(Y<0.5) = 0;
    Y = Y';
end
function [z] = sigmoid(x)
    z = 1.0 ./ (1.0 + exp(-x));
end
function [W] = LogisticRegression(data,label)
    % w :  1x(d+1)
    % data: nx(d+1)
    % label: nx1
    N = size(data,1);
    D = size(data,2);
    X = double(cat(2,ones(N,1),data));
    W = double(zeros(1,D+1));
    Diff = 1;Diff_old = 0;
    alpha = 0.05;
    W_Bar = double(ones(size(W)));
    %while Diff ~= Diff_old
    for i=1:20
        Diff_old = Diff;
        W_Old = W;        
        T = W*X';
        P = sigmoid(T);
        W_Bar = (label'-P)*X;
        W = W + alpha*W_Bar;  %new value of w
        Diff = sum(abs(W-W_Old)); % sum of absolute differences    
    end
    maxw = max(W);
    minw = min(W);
    W = W/(maxw-minw);
end