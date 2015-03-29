# -*- coding: utf-8 -*-
# -*- coding: utf-8 -*-
# % Course     : Statistical Methods in Artificial Intelligence
# % Description: Classifiers
# % Author     : Sanchit Aggarwal
# % Date       : 7-September-2012
# % Copyright (c) 2014 Sanchit Aggarwal. All rights reserved.
"""
Created on Fri Sep 07 05:10:25 2012

@author: sanchit
"""
from Dataset import *
from numpy import *
from Classifier import *
import sys
import os

def implement():
    try:
        set_printoptions(3)
        dataset={1:'iris.csv',2:'yeast.csv',3:'scale.csv'}          
        classposition={1:4,2:8,3:0}
        #to select the dataset
        index=input('''Select the DataSet\n
        1. Iris
        2. yeast
        3. balancescale--->''')
        
        algo=input('''Algorithms:
          1: Single Sample Perceptron Learning (fixed eta)
          2: Batch Perceptron Learning (variable eta)
          3: Single sample Relaxation (variable eta)
          4: Batch Relaxation Learning (variable eta)
          5: MSE using Pseudo Inverse
          6: MSE using LMS Procedure--->''')
        comb=input('''Combination:
          1: 1 vs. Rest
          2: 1 vs. 1 with Majority voting
          3: 1 vs. 1 with DDAG
          4: BHDT.--->''')
        folds=input('''Fold:enter value greater >1  :''')
        if folds==1:
            folds=2
        if comb==3 or comb==4:
            comb=1
    #Reading the dtaset selected and  creating the instance of DataSet Class
        filename=dataset[index]
        Dataset_Complete=DataSet([])
        Dataset_Complete.readData(filename,classposition[index])
        outfilename='output_'+filename
        Dataset_Complete.writeData(outfilename)
        crossValidate(Dataset_Complete,folds,algo,comb,filename)
        return True
    except:
            print "Exception in Implement",sys.exc_info()
            return False
    
flag=1
while flag:
    implement()
    flag=input("Continue Training (0/1):")