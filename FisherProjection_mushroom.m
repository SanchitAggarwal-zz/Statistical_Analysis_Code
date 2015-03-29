% Course     : Machine Learning Homework Assigment 1
% Description: Fisher Linear Disciminant
% Author     : Sanchit Aggarwal
% Date       : 15-September-2014
% Copyright (c) 2014 Sanchit Aggarwal. All rights reserved.

filename = '../Dataset/Mushroom_Dataset/processedData.csv';
% delimiterIn = ',';
% %headerlinesIn = 1;
% Data = importdata(filename,delimiterIn);
% 
% p = Data(1);
% C = strsplit(p,delimiterIn);

MushroomData = csvread(filename);
MD = MushroomData(:,2:end);
% coeff = pca(MD, 'Algorithm','eig','Centered', true, 'NumComponents', 2,'Rows','all')

% cv = cov(MD);
% [eig_vectors, eig_values] = eig(cv);
% [d,q] = sort(-diag(eig_values));
% eig_vectors = eig_vectors(:,q);
% pca_proj = MD * eig_vectors(:,1:end);

CenteredData = MD; %bsxfun(@minus, MD, mean(MD,1));   
CovMat = cov(MD); %(CenteredData'*CenteredData)./(size(CenteredData,1)-1);                 

[Eig_Vector Eig_Values] = eig(CovMat);
[Eig_Values Order] = sort(diag(Eig_Values), 'descend');
Eig_Vector = Eig_Vector(:,Order);

PCA_Proj_Data = CenteredData*Eig_Vector(:,1:end);


figure
edible = find(MD(1:end,1) == 1);
poisonous = find(MD(1:end,1) == 0);
X = PCA_Proj_Data(1:end,1);
Y = PCA_Proj_Data(1:end,2);
plot(X(edible,1),Y(edible,1),'ro')
hold on;
plot(X(poisonous,1),Y(poisonous,1),'bx')
title('Scatter Plot for Mushroom Data on Top Two Principal Components')
xlabel('First Principal Component') % x-axis label
ylabel('Second Principal Composnet') % y-axis label
legend('edible = red circle','poisonous = blue cross')
% S = 100
% C = MD(1:200,1);
% scatter(X,Y,S,C);
% 
% zoom(2)


%% Fisher Projection
% Calculate mean of the Classes
Class_1_data = MD(edible,1:end);
Class_2_data = MD(poisonous,1:end);
Mean_Class_1 = mean(Class_1_data); 
Mean_Class_2 = mean(Class_2_data);

% Calculate variance of the Classes
Variance_Class_1 = 1+var(double(Class_1_data));
Variance_Class_2 = 1+var(double(Class_2_data));

% Compute Fisher Image
BetweenClass = (Mean_Class_1 - Mean_Class_2).*(Mean_Class_1 - Mean_Class_2);
WithinClass = ((size(Class_1_data,1)*Variance_Class_1 + size(Class_2_data,1)*Variance_Class_2));
Fisher_Projection = BetweenClass ./ WithinClass;
Fisher_Projection = Fisher_Projection.*100000;
[Fisher_Projection Order] = sort(Fisher_Projection, 'descend');
Fisher_Projection(1:10)