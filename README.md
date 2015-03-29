# Statistical_Analysis_Code

Matlab, Pyhton and C++ Implementation of various algorithms of Machine Learning and Data Mining.These are implemented as a requirment for my postgraduation courses (Cloud Computing,Machine Learning, SMAI). Some of the algorithms are:

- **Clustering**
  1. Agglomerative Clustering (AgglomerativeClustering.m)
  2. K-Mean Clustering (KMeanClustering.m)
  3. K-Mean with FFP (KMeanFFP.m)
  4. K-mean FFP and PCA (KmeanFFP_PCA.m)
  5. Kmean_FFP_Fisher (Kmean_FFP_Fisher.m.m)
  6. Soft K-Means (SoftKMeans.m)
  7. Spehrical K-Means (SpehricalKMeans.m)
  8. K Nearest Neighbour (KNN.m)
  9. Gaussian Mixture Models (GMM.cpp)
  
- **Classification**
  1. BaysianClassifier.m
  2. Various Classifiers (Classifier.py, Implement_classifier.py,Dataset.py)
      - Single Sample Perceptron Learning (fixed eta)
      - Batch Perceptron Learning (variable eta)
      - Single sample Relaxation (variable eta)
      - Batch Relaxation Learning (variable eta)
      - MSE using Pseudo Inverse
      - MSE using LMS Procedure
      - **Combinations for validation**
        - 1 vs. Rest
        - 1 vs. 1 with Majority voting
        - 1 vs. 1 with DDAG
        - BHDT  
  3. Decsion Tree ( DecisionTreeMushroom.m )
  4. Mixture of Gaussians (MixtureOfGaussian.m)
  5. Naive Bayes ( NaiveBayes_Mushroom.m, NaiveBayes_NewsGroup.m)
  
- **Regression**
  1. Logistic Regression (LogisticRegression.m, tryNR.m)

- **Preprocessing**
  1. For Preprocessing Mushroom Data (Data_Preprocessing.py)

- **Feature Reduction**
  1. Fisher Linear Discimination (FisherLinearDiscriminant.m, FisherProjection_mushroom.m)
  3. Principal Component Analysis ( PCA.m )
  4. PCA with Singular Value Decomposition (PCASVD.m)
  5. Direct LDA (directlda.m)

- **Hadoop**
  1. K-Means on Hadoop with Map Reduce (Hadoop-KMeans)
  2. Word Count on Map Reduce (Hadoop-MapReduce_WordCount)
