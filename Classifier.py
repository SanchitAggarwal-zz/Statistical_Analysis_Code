# -*- coding: utf-8 -*-
# % Course     : Statistical Methods in Artificial Intelligence
# % Description: Classifiers
# % Author     : Sanchit Aggarwal
# % Date       : 31-August-2012
# % Copyright (c) 2014 Sanchit Aggarwal. All rights reserved.
"""
Created on Fri Aug 31 04:24:46 2012

@author: luminous
"""

from Dataset import *
from numpy import *
import sys
import os
import itertools

class LinearClassifier:	# Class that carries out training and classification as well as
    algorithm=0		     # store and read the learned model in/from a file.
    combination=0	
    learn_Model=DataSet([])
    load_Model=DataSet([])
    filename=None
    modelfilename=None
    confusion_Matrix=0
    set_classes=[]
    pairs=[]
    def __init__(self,algorithm,combination,filename,trainData):					
        try:
            classes=[]
            for item in trainData.Data:
                classes.append(item.classlabel)
            self.set_classes=set(classes)
            no_of_class=len(self.set_classes)
            self.confusion_Matrix=zeros((no_of_class,no_of_class))
            self.algorithm=algorithm
            self.combination=combination
            self.filename=filename
            self.modelfilename="Model_Algo"+str(self.algorithm)+"_Comb"+str(self.combination)+"_"+self.filename
            self.learnModel(trainData)
            self.pairs=[]         
            '''if self.combination==1:
                for each_class in self.set_classes:
                    leach_class=list(each_class)
                    print leach_class
                print self.pairs
            elif self.combination==2:
                self.pairs=[]
            '''
            #if self.combination==1:
            #    self.pairs = list(self.set_classes)
            #elif self.combination==2:
                #self.pairs=list(itertools.combinations(list(self.set_classes), 2))
            #print  self.pairs
                
        except:
            print 'exception in LiniearClasifier Initialization',sys.exc_info()
            
    def augmented_Feature_Vecotor(self,trainData,classify_class):
        try:
            if self.combination==1:
                #print classify_class          
                feature_vectors=[]
                for d_item in trainData.Data:
                    if d_item.classlabel!=classify_class:
                        feature_vectors.append(hstack((-1,-1*d_item.feature))) #negate the vectors which are not in same class
                    else:
                        feature_vectors.append(hstack((1,d_item.feature)))
                return feature_vectors
            elif self.combination==2:
                listclass=list(self.set_classes)
                index=listclass.index(classify_class)
                class2=listclass[(index+1)%len(listclass)]
                feature_vectors=[]
                for d_item in trainData.Data:
                    if d_item.classlabel==class2:
                        feature_vectors.append(hstack((-1,-1*d_item.feature))) #negate the vectors which are not in same class
                    elif d_item.classlabel==classify_class:
                        feature_vectors.append(hstack((1,d_item.feature)))
                #print classify_class,class2
                return feature_vectors
        except:
            print 'Exception in augmented_Feature_Vecotor',sys.exc_info()
            return []
            
    def single_Perceptron(self,trainData):
        try:
            print "In Single Perceptron"
            Aug_trainData=[]
            l_model=DataSet([])
            for class_l in  self.set_classes:
                Aug_trainData=self.augmented_Feature_Vecotor(trainData,class_l)               
                weight_vector=ones(shape(Aug_trainData)[1])            
                flag=1
                count=0
                while flag and count<1000:            
                    flag=0
                    count+=1
                    for item in Aug_trainData:
                        if dot(item,weight_vector)<0:
                            flag=1                   
                            weight_vector=weight_vector+item
                
                learn_item=DataItem(class_l,weight_vector)
                l_model.Data.append(learn_item)
            return l_model
        except:
            print 'Exception in single_Perceptron',sys.exc_info()
            return []

    def batch_Perceptron(self,trainData):
        try:
            print "InBatch Perceptron"
            Aug_trainData=[]
            l_model=DataSet([])
            for class_l in  self.set_classes:
                Aug_trainData=self.augmented_Feature_Vecotor(trainData,class_l)               
                weight_vector=ones(shape(Aug_trainData)[1])
                eta=1.0                
                flag=1
                count=0
                while flag and count<1000:            
                    flag=0
                    temp_vector=zeros(shape(Aug_trainData)[1])
                    count+=1
                    for item in Aug_trainData:
                        if dot(item,weight_vector)<0:
                            flag=1                   
                            temp_vector+=item
                            #print temp_vector,item,eta
                    eta=float(1)/count
                    weight_vector+=eta*temp_vector
                print class_l,weight_vector,count,eta
                learn_item=DataItem(class_l,weight_vector)
                l_model.Data.append(learn_item)
            return l_model
        except:
            print 'Exception in single_Perceptron',sys.exc_info()
            return []
            
    def single_Relaxation(self,trainData):
        try:
            print "In single_Relaxation"
            margin=1
            Aug_trainData=[]
            l_model=DataSet([])
            for class_l in  self.set_classes:
                Aug_trainData=self.augmented_Feature_Vecotor(trainData,class_l)               
                weight_vector=ones(shape(Aug_trainData)[1])
                eta=1.0                
                flag=1
                count=0
                while flag and count<1000:            
                    flag=0
                    count+=1
                    eta=float(1)/count
                    for item in Aug_trainData:
                        dot_porduct=dot(item,weight_vector)                      
                        multiplier=float(margin-dot_porduct)/(linalg.norm(item)**2) 
                        if dot_porduct<=margin:
                            flag=1                   
                            weight_vector=weight_vector+(eta*multiplier*item)
                print class_l,weight_vector,count,eta,linalg.norm(item)
                learn_item=DataItem(class_l,weight_vector)
                l_model.Data.append(learn_item)
            return l_model
        except:
            print 'Exception in single_Relaxation',sys.exc_info()
            return []

    
    def batch_Relaxation(self,trainData):
        try:
            print "In batch_Relaxation"
            margin=1
            Aug_trainData=[]
            l_model=DataSet([])
            for class_l in  self.set_classes:
                Aug_trainData=self.augmented_Feature_Vecotor(trainData,class_l)               
                weight_vector=ones(shape(Aug_trainData)[1])
                eta=1.0                
                flag=1
                count=0
                while flag and count<1000:            
                    flag=0
                    temp_vector=zeros(shape(Aug_trainData)[1])
                    count+=1
                    for item in Aug_trainData:
                        dot_porduct=dot(item,weight_vector)                      
                        multiplier=float(margin-dot_porduct)/(linalg.norm(item)**2) 
                        if dot_porduct<=margin:
                            flag=1                   
                            temp_vector=temp_vector+(multiplier*item)
                            #print temp_vector,item,eta
                    eta=float(1)/count
                    weight_vector+=eta*temp_vector
                print class_l,weight_vector,count,eta
                learn_item=DataItem(class_l,weight_vector)
                l_model.Data.append(learn_item)
            return l_model
        except:
            print 'Exception in batch_Relaxation',sys.exc_info()
            return []

    def pseudo_Inverse(self,trainData):
        try:
            print "In Pseudo_Inverse"
            Aug_trainData=[]
            l_model=DataSet([])
            for class_l in  self.set_classes:
                Aug_trainData=self.augmented_Feature_Vecotor(trainData,class_l)               
                weight_vector=ones(shape(Aug_trainData)[1])                            
                column_b=ones(shape(Aug_trainData)[0])
                weight_vector=dot(linalg.pinv(Aug_trainData),column_b)
                print class_l,weight_vector
                learn_item=DataItem(class_l,weight_vector)
                l_model.Data.append(learn_item)
            return l_model
        except:
            print 'Exception in Pseudo_Inverse',sys.exc_info()
            return []

    def lms_Procedure(self,trainData):
        try:
            print "In lms_Procedure"
            margin=1
            theta=0
            Aug_trainData=[]
            l_model=DataSet([])
            for class_l in  self.set_classes:
                Aug_trainData=self.augmented_Feature_Vecotor(trainData,class_l)               
                weight_vector=ones(shape(Aug_trainData)[1])
                eta=1.0                
                flag=1
                count=0
                while flag and count<1000:            
                    flag=0
                    count+=1
                    eta=float(1)/count
                    temp_vector=zeros(shape(Aug_trainData)[1])
                    for item in Aug_trainData:
                        dot_porduct=dot(item,weight_vector)                                              
                        multiplier=float(margin-dot_porduct)
                        #print dot_porduct,multiplier
                        #temp_vector+=multiplier*item
                        #print temp_vector
                        if dot(item,weight_vector)<theta:
                            flag=1                   
                            weight_vector=weight_vector+item
                print class_l,weight_vector,count,eta
                learn_item=DataItem(class_l,weight_vector)
                l_model.Data.append(learn_item)
            return l_model
        except:
            print 'Exception in lms_Procedure',sys.exc_info()
            return []

# learn the parameters of the classifier from possibly multiple training datasets
# using a specific learning algorithm and combination strategy. 
# The function should return the training error in [0,1].
    def learnModel(self,trainData):        
        try:
            print 'learning the model...'
            if self.algorithm==1 :#and self.combination==1:
                self.learn_Model=self.single_Perceptron(trainData)
            
            elif self.algorithm==2 :#and self.combination==1:
                self.learn_Model=self.batch_Perceptron(trainData)
            
            elif self.algorithm==3 :#and self.combination==1:
                self.learn_Model=self.single_Relaxation(trainData)
            
            elif self.algorithm==4:# and self.combination==1:
                self.learn_Model=self.batch_Relaxation(trainData)
                
            elif self.algorithm==5 :#and self.combination==1:
                self.learn_Model=self.pseudo_Inverse(trainData)
                
            elif self.algorithm==6:# and self.combination==1:
                self.learn_Model=self.lms_Procedure(trainData)
            #print "model saved in file ",self.modelfilename
            self.saveModel()
        except:
            print "Exception in learnModel",sys.exc_info()
            return
    def loadModel(self):		# Loads classifier model from a file
        self.load_Model=DataSet([])        
        os.path.relpath(self.modelfilename,os.curdir)
        try:          
            with open(self.modelfilename, 'rb') as f:
                reader = csv.reader(f)
                for row in reader:
                    c_label=row.pop(0)                   
                    data_item=DataItem(c_label,row)
                    self.load_Model.Data.append(data_item)
            return True
        except:
            print "exception in Load Model",sys.exc_info()
            return False	
    
    def saveModel(self):		# Saves the learned model parameters into a file
        try:
            os.path.relpath(self.modelfilename,os.curdir)
            File_Write = open(self.modelfilename, "w+") #open on append mode
            for d_item in self.learn_Model.Data:
                row=None                
                row=str(d_item.classlabel)
                for pnt in d_item.feature:
                    row+=','+str(pnt)
                row+="\n"
                File_Write.write(row)
            File_Write.close()
            return True
        except:
            print "exception in Save Model",sys.exc_info()
            return False     
# Classifies a DataItem and returns the class-label
    def classifySample(self,d_Item):
        try:
            actual_feature=hstack((1,d_Item.feature))
            for weight_vector in self.load_Model.Data:
                if dot(actual_feature,weight_vector.feature)>=0:                      
                        i_actual=list(self.set_classes).index(d_Item.classlabel)
                        i_predicted=list(self.set_classes).index(weight_vector.classlabel)
                        self.confusion_Matrix[i_actual][i_predicted]+=1
                        return True
        except:
            print "Exception in Classify Sample",sys.exc_info()
            return False

# classify a set of testDataItems and return the error rate in [0,1].
# Also fill the entries of the confusionmatrix.
    def classifyDataset(self,testSet):#,ConfusionMatrix):
        try:
            for item in testSet.Data:     
                self.classifySample(item)
            return True
        except:
            print "Exception in classifyDataset",sys.exc_info()
            return False

# Divide the dataset and performa an n-fold cross-validation. Compute the
# average error rate in [0,1]. Fill in the standard deviation and confusion matrix.
def crossValidate(complete,folds,algo,comb,filename):
    try:
        partial_sets=splitDataset(complete,folds,0)        
        merged_set=DataSet([])
        #no_of_class=len(classifier.set_classes)
        #avg_confusion_Matrix=zeros((no_of_class,no_of_class))
        error=zeros(folds)
        for i in range(0,folds):
            indicestoMerge = list(xrange(folds))
            indicestoMerge.pop(i)
            merged_set=mergeDatasets(partial_sets,folds-1,indicestoMerge)
            classifier=LinearClassifier(algo,comb,filename,merged_set)
            classifier.loadModel()
            classifier.classifyDataset(partial_sets[i])
            total_test_samples=len(partial_sets[i].Data)
            error[i]=float(total_test_samples-classifier.confusion_Matrix.trace())/total_test_samples
            print "Confusion Matrix:%s\n%s"%(i+1,classifier.confusion_Matrix)
        #avg_confusion_Matrix/=folds
        Mean_error=error.mean()
        Standard_deviation=error.std()
        print "Mean Error:%s Standard Deviation:%s"%(Mean_error,Standard_deviation)
        print "model saved in file ",classifier.modelfilename
        return True
    except:
            print "Exception in crossValidate",sys.exc_info()
            return False
