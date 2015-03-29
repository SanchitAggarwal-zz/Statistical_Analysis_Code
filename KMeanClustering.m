% Course     : Machine Learning Homework Assigment 2
% Description: K Means Clustering
% Author     : Sanchit Aggarwal
% Date       : 11-September-2014 12:14 A.M.
% Copyright (c) 2014 Sanchit Aggarwal. All rights reserved.

clear all
clc
load '../Dataset/MNIST_Dataset/mnist_all.mat'
X = cat(1, train0, train1, train2, train3, train4, train5, train6, train7, train8, train9);


%% Random Initialization
% K = 5; 
% K = 10; 
% K = 15;
% K = 20;
K = 25;
total = 30;
FullPurity = zeros(1,total);
Full_SumD = zeros(1,total);
for run = 1:total
    [IDX,C,sumd] = kmeans(double(X),K);


    %% Purity of cluster
    % L = {Lc = Set of points in class c}
    % M = {Mk = Set of points in cluster k}

    ClassIndx = cat(1, 1 * ones(size(train0,1),1),...
                       2 * ones(size(train1,1),1),...
                       3 * ones(size(train2,1),1),...
                       4 * ones(size(train3,1),1),...
                       5 * ones(size(train4,1),1),...
                       6 * ones(size(train5,1),1),...
                       7 * ones(size(train6,1),1),...
                       8 * ones(size(train7,1),1),...
                       9 * ones(size(train8,1),1),...
                      10 * ones(size(train9,1),1));

    Classes = 10;
    Purity = 0;
    for k = 1:K
        LM = zeros(1,Classes); % no of classes
        for c = 1:Classes
            LM(c) = sum( (ClassIndx == c) & (IDX == k));  %L_c intersect M_k
        end
        Purity = Purity + max(LM);
    end
    FullPurity(run) = Purity/size(IDX,1);
    Full_SumD(run) = sum(sumd);
end

MFS = mean(Full_SumD)
SFS = std(Full_SumD)
MP = mean(FullPurity)
SP = std(FullPurity)

%% Drwa Image of cluster means
for k = 1:K
    ClusterImage = image(reshape(C(k,:),28,28)');
    figure, imshow(ClusterImage);
end

