% Course     : Machine Learning Homework Assigment 3
% Description: Mixture of Gaussian on MNIST Data.
% Author     : Sanchit Aggarwal
% Date       : 3-October-2014
% Copyright (c) 2014 Sanchit Aggarwal. All rights reserved.

load '../Dataset/MNIST_Dataset/mnist_all.mat';

% Learning Gausian Mixture
[mixture0, GMModel.train0] = GaussianMixture(train0, 10, 3, true, 1e5);
[mixture1, GMModel.train1] = GaussianMixture(train1, 10, 3, true, 1e5);
[mixture2, GMModel.train2] = GaussianMixture(train2, 10, 3, true, 1e5);
[mixture3, GMModel.train3] = GaussianMixture(train3, 10, 3, true, 1e5);
[mixture4, GMModel.train4] = GaussianMixture(train4, 10, 3, true, 1e5);
[mixture5, GMModel.train5] = GaussianMixture(train5, 10, 3, true, 1e5);
[mixture6, GMModel.train6] = GaussianMixture(train6, 10, 3, true, 1e5);
[mixture7, GMModel.train7] = GaussianMixture(train7, 10, 3, true, 1e5);
[mixture8, GMModel.train8] = GaussianMixture(train8, 10, 3, true, 1e5);
[mixture9, GMModel.train9] = GaussianMixture(train9, 10, 3, true, 1e5);

% Test data
testData = cat(1, test0, test1, test2, test3, test4, test5, test6, test7, test8, test9);

GMModel.test0 = GMClassLikelihood(GMModel.train0, testData);
GMModel.test1 = GMClassLikelihood(GMModel.train1, testData);
GMModel.test2 = GMClassLikelihood(GMModel.train2, testData);
GMModel.test3 = GMClassLikelihood(GMModel.train3, testData);
GMModel.test4 = GMClassLikelihood(GMModel.train4, testData);
GMModel.test5 = GMClassLikelihood(GMModel.train5, testData);
GMModel.test6 = GMClassLikelihood(GMModel.train6, testData);
GMModel.test7 = GMClassLikelihood(GMModel.train7, testData);
GMModel.test8 = GMClassLikelihood(GMModel.train8, testData);
GMModel.test9 = GMClassLikelihood(GMModel.train9, testData);

FisherImage = image(reshape(GMModel.train9,28,28)');
figure, imshow(FisherImage);