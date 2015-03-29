% Course     : Machine Learning Homework Assigment 3
% Description: Soft K-Means Clustering on MNSIT Data.
% Author     : Sanchit Aggarwal
% Date       : 3-October-2014 01:39 P.M.
% Copyright (c) 2014 Sanchit Aggarwal. All rights reserved.


function HW3_Q2_SoftKMeans
    colorcode=hsv(10);
    i= figure;
    for lambda = 1:1:9
        [cost,means] = getCost(lambda/10);
        plot(cost,'Color',colorcode(lambda,:));
        set(i,'name','Soft Means Clustering');
        title('Soft K Means: Clustering Cost vs Iterations');
        xlabel('Iterations');
        ylabel('Clustering Cost');
        hold on
    end
    Legend=cell(10,1)
    for iter=1:10
        Legend{iter}=strcat('lambda = ', num2str(iter/10));
    end
    legend(Legend);
    hold off;
    
%     [cost,means] = getCost(5/10);
%     i=figure
%     for j=1:10
%         c_image=zeros(7,7);
%         c_image=reshape(means(j,1:49),[7 7]);
%         if j/5 < 1
%             subplot(1,5,mod(j,5)), subimage(c_image)
%         else
%             subplot(2,5,mod(j,5)), subimage(c_image)
%         end
%         title(['Cluster ' num2str(j)]);
%         %imwrite(c_image,['q2_' num2str(j) '.png']);
%         hold on;
%      end
end

function [cost,means] = getCost(lambda)
    %lambda: decay constant
    %sigma: initial variance
    %delta: degree of association of datapoint to all clusters
    %k = no of means
    %d = dimension
    %n = no of data points
    %t = iterations
    
    data = readData;
    sigma  = norm(var(data));
    k = 10;
    d = 50;
    t = 100;
    n = size(data,1);
    %initialization
    means = initialmeans(data,k);
    %new_means = zeros(k,d);
    delta = zeros(n,k);
    dist = zeros(n,1);
    cost = zeros(1,t);
    for t1 = 1:t
        sigma = lambda * sigma;
        %E Step
        for j = 1:k
            for i = 1:n
                dist(i)=norm(data(i,:)-means(j,:));
                term = -1 * (dist(i)/sigma)*(dist(i)/sigma);
                delta(i,j) = exp(term);
                cost(1,t1) = cost(1,t1) + delta(i,j)*dist(i);
            end
        end
        %means = new_means;
        %M Step
        for j = 1:k
            temp = 0;
            for i = 1:n
                temp = temp + delta(i,j) * data(i,:);
            end
            means(j,:) = temp/sum(delta(:,j));
        end
    end
    disp(cost);
end

function data = readData
    load '../Dataset/MNIST_Dataset/mnist_all.mat';
    t0 = datasample(train0,100,'Replace',false);
    t1 = datasample(train1,100,'Replace',false);
    t2 = datasample(train2,100,'Replace',false);
    t3 = datasample(train3,100,'Replace',false);
    t4 = datasample(train4,100,'Replace',false);
    t5 = datasample(train5,100,'Replace',false);
    t6 = datasample(train6,100,'Replace',false);
    t7 = datasample(train7,100,'Replace',false);
    t8 = datasample(train8,100,'Replace',false);
    t9 = datasample(train9,100,'Replace',false);
    % sample 1000 points from MNSIT
    sample_data = cat(1, t0, t1, t2, t3, t4, t5, t6, t7, t8, t9);
    % PCA of the sample data into 50 dimensional space
    cv=cov(double(sample_data));
    [e_vec,e_val]  =  eig(cv);
    [d,q]=sort(-diag(e_val));	
    data=double(sample_data)*e_vec(:,q(1:50));
end

function means = initialmeans(data,k)
    means = zeros(10,50);
    for j = 1:10
        means(j,:) = data(randi([100*j-99,j*100]),:);
    end
end

