% Course     : Machine Learning Homework Assigment 2
% Description: Decision Trees on Mushroom Data
% Author     : Sanchit Aggarwal
% Date       : 15-September-2014
% Copyright (c) 2014 Sanchit Aggarwal. All rights reserved.

clear all
clc

filename = '../Dataset/Mushroom_Dataset/mushroom_data.csv';
MushroomData = csvread(filename);
K = size(MushroomData, 1);
PartitionIndex = randperm(K);

%% Random Partion into 5 buckets

P1 = MushroomData(PartitionIndex(1:floor(K/5)), :);
P2 = MushroomData(PartitionIndex(floor(K/5+1):floor(2*K/5)), :);
P3 = MushroomData(PartitionIndex(floor(2*K/5+1):floor(3*K/5)), :);
P4 = MushroomData(PartitionIndex(floor(3*K/5+1):floor(4*K/5)), :);
P5 = MushroomData(PartitionIndex(floor(4*K/5+1):end), :);

ExperimentsStart = [1,floor(K/5+1),floor(2*K/5+1),floor(3*K/5+1),floor(4*K/5+1)];
ExperimentEnd = [floor(K/5),floor(2*K/5),floor(3*K/5),floor(4*K/5),K];

index = 1:5;
Perm = nchoosek(index,2);
Depths = [4,8,12,16,20];
Accuracies = zeros(size(Perm,1),size(Depths,1));

%% Decision Tree Evaluation
for i=1:size(Perm,1)
    % Training and Tresitn Split in to 5 buckets
    p1 = MushroomData(PartitionIndex(ExperimentsStart(Perm(i,1)):ExperimentEnd(Perm(i,1))), :);
    p2 = MushroomData(PartitionIndex(ExperimentsStart(Perm(i,2)):ExperimentEnd(Perm(i,2))), :);
    
    TestingSet = cat(1, p1,p2);
    TestData = TestingSet(:, 2:end);
    TestLabel = TestingSet(:, 1);
    
    TrainingIndex = setdiff(index,Perm(i,:));
    p3 = MushroomData(PartitionIndex(ExperimentsStart(TrainingIndex(1)):ExperimentEnd(TrainingIndex(1))), :);
    p4 = MushroomData(PartitionIndex(ExperimentsStart(TrainingIndex(2)):ExperimentEnd(TrainingIndex(2))), :);
    p5 = MushroomData(PartitionIndex(ExperimentsStart(TrainingIndex(3)):ExperimentEnd(TrainingIndex(3))), :);
    
    TrainingSet = cat(1, p3,p4,p5);
    TrainingData = TrainingSet(:, 2:end);
    TrainingLabel = TrainingSet(:, 1);
    
    % DT Classifier
    Tree = ClassificationTree.fit(TrainingData, TrainingLabel, 'prune', 'off');
    
    %% Depth vs. Accuracy Graph
    for j=1:length(Depths);
        Tree = prune(Tree, 'level', Depths(j));
        view(Tree);

        PredictedValue = predict(Tree, TestData);
        ComfusionMat = confusionmat(TestLabel, PredictedValue);

        N = sum(ComfusionMat(:));
        Error = ( N-sum(diag(ComfusionMat)) ) / N;
        Accuracy(i,j) = 100 - Error;
    end
    figure;
    plot(Depths, Accuracy(i,:));
    hold off;
end
Mean = mean(Accuracy);
StandardDeviation = std(Accuracy);
