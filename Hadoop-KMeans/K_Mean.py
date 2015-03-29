#!/usr/bin/env python
# % Course     : Cloud Computing
# % Description: Kmeans Map Reduce
# % Author     : Sanchit Aggarwal
# % Date       : 28-August-2012
# % Copyright (c) 2014 Sanchit Aggarwal. All rights reserved.# -*- coding: utf-8 -*-
"""
Created on Tue Aug 28 04:34:08 2012

@author: sanchit
"""

import clean_file
import random
import math


def Compute_KMean(Seed,K,data_point,N,classposition):
    Cluster=[]
    for j in range(0,K):
        Cluster.append([])
    for i in range(0,N):        #Calculating the cluster index for each datapoint
        Eucledian_dist=[]
        for j in range(0,K):    #Calculating the min distance from each seed
            #numpy.linalg.norm()
            Distance=0.0
            for m in range(0,classposition):
                Distance+=math.pow(float(Seed[j][m])-float(data_point[i][m]),2)                
                Distance=round(math.sqrt(Distance),2)
            Eucledian_dist.append(Distance)
        cluster_index=Eucledian_dist.index(min(Eucledian_dist))
        #print cluster_index,data_point[i]
        #print Eucledian_dist
        Cluster[cluster_index].append(data_point[i])
    return Cluster

def New_Centorid(Cluster,K,classposition):
    Centroid=[]
    for i in range(0,K):
        cal_centroid=[ round(sum(x)/len(Cluster[i]),2) for x in zip(*Cluster[i]) ]
        Centroid.append(cal_centroid[0:classposition])
    return Centroid
    
file_path='car.csv'
classposition=6
K=4
#Normalizing the dataset
data_point=clean_file.Normalize_Data(file_path,classposition)
random.shuffle(data_point)
#print data[0]
#seed without class information
seed=[]
for i in range(0,K):
    seed.append(data_point[i][0:classposition])
flag=1
while(flag):
    cluster=Compute_KMean(seed,K,data_point,len(data_point),classposition)
    centroid=New_Centorid(cluster,K,classposition)
    #for i in range(0,K):
        #print centroid[i],seed[i]  
    if centroid==seed:
        #print flag        
        flag=0
        
    else:
        seed=centroid      
        flag+=1
#    print "-----------------------------"
for i in range(0,K):
    for j in range(0,len(cluster[i])):
        print cluster[i][j]
    print "---cluster--",i
for i in range(0,K):
    print centroid[i]
    #print seed[i]
#print len(cluster[i])


