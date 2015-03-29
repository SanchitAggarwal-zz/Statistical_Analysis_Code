% Course     : Machine Learning Homework Assigment 3
% Description: Agglomerative Clustering on News Group Data.
% Author     : Sanchit Aggarwal
% Date       : 3-October-2014
% Copyright (c) 2014 Sanchit Aggarwal. All rights reserved.

function HW3_Q3_AgglomerativeClustering
    clear all;
    close all;
    clc;
    tfidf = '../Dataset/20news-bydate/tfidf.mat'
    if ~exist(tfidf)
        getTFIDF
    else
        load(tfidf) ;
    end
    tfidf(isnan(tfidf)) = 0;
    Z1 = linkage(tfidf, 'average', 'cosine');
    Z2 = linkage(tfidf, 'centroid', 'cosine');
    Z3 = linkage(tfidf, 'complete', 'cosine');
    Z4 = linkage(tfidf, 'median', 'cosine');
    
    plotDendogram(Z1,'average');
    plotDendogram(Z2,'centroid');
    plotDendogram(Z3,'complete');
    plotDendogram(Z4,'median');
end

function tfidf = getTFIDF
    load '../Dataset/20news-bydate/newsgroupdata.mat';
    load '../Dataset/20news-bydate/top1000.mat'
    load '../Dataset/20news-bydate/data500.mat'
    totalDocs = length(unique(data500.docId));

    %% Finding the Inverse Document Frequency
    for i=1:size(top1000, 1)
        % Find out the docs in which the current words occurs
        idx = find(data500.wordIdx == top1000(i,1));
        % docs in which the current word occurs.
        docsI = data500.docId(idx);
        % Find the total number of documents in which the word occurs.
        numDocs = length(unique(docsI));
        % Find the INVERSE DOCUMENT FREQUENCY
        idf(i) = log(totalDocs/numDocs);    

    end

    %% Finding the Term Frequency (number of occurrences of term $t$ in document $d$)

    % Finding unique docs
    Docs = unique(data500, 1);
    uniqueDocs = Docs(:, 1);

    % Finding the term frequency
    termFreq = zeros(500,1000);
    for t=1:size(top1000, 1)
        total = 0;
        for d=1:size(uniqueDocs, 1)
            % Find the docs in which the term occurs.
            idx = find(data500.docId == uniqueDocs.docId(d) & data500.wordIdx == top1000(t, 1));

            % If term is not present in doc
            if ~isempty(idx)        
                termFreq(d,t) = data500(idx, 3);
            else 
                 termFreq(d,t) = 0;
            end    
        end    
    end

    disp(size(termFreq));
    termFreq;

    %% Finding the TFIDF
    for t = 1:size(idf,2)
        tfidf(:,t) = termFreq(:,t)*idf(t);
    end
end


function plotDendogram(Z,similarity)
    figure
    subplot(5,1,1)
    [~,T1] = dendrogram(Z,10);
    title(['metric: ' similarity ' clusters: ' num2str(10)]);
    
    subplot(5,1,2)
    [~,T2] = dendrogram(Z,20);
    title(['metric:' similarity ' clusters:' num2str(20)]);
    
    subplot(5,1,3)
    [~,T3] = dendrogram(Z,30);
    title(['metric:' similarity ' clusters:' num2str(30)]);
    
    subplot(5,1,4)
    [~,T4] = dendrogram(Z,40);
    title(['metric:' similarity ' clusters:' num2str(40)]);
    
    subplot(5,1,5)
    [~,T5] = dendrogram(Z,50);
    title(['metric:' similarity ' clusters:' num2str(50)]);
end

