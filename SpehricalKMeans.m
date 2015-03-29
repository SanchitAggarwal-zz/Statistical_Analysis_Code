% Course     : Machine Learning Homework Assigment 2
% Description: Spherical K-Means Clustering on Newsgroup text data.
% Author     : Sanchit Aggarwal
% Date       : 15-September-2014 10:52 P.M.
% Copyright (c) 2014 Sanchit Aggarwal. All rights reserved.

clear all;
close all;
clc;

train = '../Dataset/20news-bydate/train.data';
test = 'dataset/20news-bydate/test.label';
data = dlmread(train,' ');  % docnum, word, wordcount
label = dlmread(test, ' ');
save -v7.3 newsdata.mat data label

load data.mat

doc_unique = unique(data(:,1));
word_unique = unique(data(:,2));
numdocs = length(doc_unique);
numwords = length(word_unique);
wordfreq = [];

for i=1:size(data,1)
    doc_index = data(i,1);
    word_index = data(i,2); 
    tf(doc_index).wf(word_index) = log(1+ data(i,3));% Document -> word1 word2 ..... (how many times the word occured in document 'i')
    docfreq(word_index).doc(doc_index) = data(i,3);	% Word -> document1 document2 ..... (how many times that word occured in document 'i')
end

    
%% (a) Compute the number of documents in which each word occurred (DocFreq(word)).
for i=1:numwords
	docfreq_count(i) = length(find(docfreq(i).doc ~= 0));		% numwordsX1
end
%%

%% (b) Compute the INVERSE DOCUMENT FREQUENCY of each word (See class notes).
for i=1:numwords
	idf(i) = log(numdocs/docfreq_count(i));				% numwordsX1
end
%%


%% (c) Compute the TFIDF representation of each document ? sparse, normalized.
tfidf = [];
for i=1:size(data,1)
	doc_index = data(i,1);
	word_index = data(i,2);
    	tfidf(doc_index).wf(word_index) = tf(doc_index).wf(word_index) * idf(word_index);
end

normalize = [];
for i=1:size(data,1)
        doc_index = data(i,1);
        word_index = data(i,2);
        normalize(doc_index) = sqrt((sum((tfidf(doc_index).wf) .^ 2)));
end

tfidf_norm = [];
for i=1:size(data,1)
        doc_index = data(i,1);
        word_index = data(i,2);
        tfidf_norm(doc_index).wf(word_index) = (tfidf(doc_index).wf(word_index))/normalize(doc_index);
end

% converting struct to matrix
tfidfnorm = zeros(numdocs, numwords);
for i=1:size(data,1)
        doc_index = data(i,1);
        word_index = data(i,2);
        tfidfnorm(doc_index, word_index) = tfidf_norm(doc_index).wf(word_index);
end
save -v7.3 tfidfnorm_5k.mat tfidfnorm
%%

%% (d) Modify the Farthest First Point algorithm for Cosine similarity and sample initial cluster centers using this modification.
load tfidfnorm_5k.mat
meanpoint = mean(tfidfnorm, 1);
distance = pdist2(tfidfnorm, meanpoint,'cosine');
[~, index]= max(distance);
clusterMeanIndex = index;
count=1
K=5
while 1
        clusterMean = tfidfnorm(clusterMeanIndex,:);
        temp = removerows(tfidfnorm, clusterMeanIndex );
        distance = pdist2(temp, clusterMean,'cosine');
        minimumDistance = min(distance,[],2);
        %disp(max(minimumDistance))
        [~, index]= max(minimumDistance);
        clusterMeanIndex = [clusterMeanIndex index];      
        count=count+1;
         if count==K
            break
        end
 end
 clusterMean = tfidfnorm(clusterMeanIndex,:);
save -v7.3 clusterMean.mat clusterMean clusterMeanIndex
%%


%% (e) Perform Clustering for K = 5, 10, 15, 20, 25 clusters of Newsgroup data.
load tfidfnorm_5k.mat
load clusterMean.mat

[IDX C] =kmeans(tfidfnorm, 5, 'start',clusterMean, 'cosine');
%}
%%


% (f) Print the TOP 10 words for each cluster center for each K.
fid = fopen('mapping.txt','r');    
tline = fgetl(fid);            
i = 1;

while ischar(tline) 
	parts = strsplit(tline, ' ');
	id(i) = str2double(parts(1));
	word(i) = parts(2);
	tline = fgetl(fid);
	i = i+1;
end

load prob9clusters.mat
load tfidfnorm_5k.mat

%names = dlmread('mapping.txt', ' ');
%id = names(:,1);
%word=names(:,2);
topkwords =[];
for i=1:5
	idx = find(IDX == i);
	dist = pdist2(tfidfnorm(idx,:),C(i,:), 'cosine');
	[ls index] = sort(dist, 'ascend');
	topDocument = tfidfnorm(index(1:10),:);
	
	for j=1:10
		[maxword ind] = max(topDocument(j,:));
		tmp = word(find(id==ind));
		topwords(i,j) = tmp;
%		disp(topwords);
	end
%	topkwords(i).top = topwords;
end
dlmwrite('topwords.txt', topwords);


% (g) Compute the PURITY measure for various K.
