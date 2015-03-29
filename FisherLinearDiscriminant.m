% Course     : Machine Learning Homework Assigment 1
% Description: Fisher Linear Disciminant
% Author     : Sanchit Aggarwal
% Date       : 15-September-2014
% Copyright (c) 2014 Sanchit Aggarwal. All rights reserved.

function FisherLinearDiscriminant(Class_1_data,Class_2_data)
    disp(size(Class_1_data));
    disp(size(Class_2_data));

    % Calculate mean of the Classes
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
    
    % Drwa Image
	FisherImage = image(reshape(Fisher_Projection,28,28)');
    figure, imshow(FisherImage);
    %imwrite(FisherImage, Filename);
end
