#!/usr/bin/env python
# % Course     : Cloud Computing
# % Description: Pre Processing of Data
# % Author     : Sanchit Aggarwal
# % Date       : 29-August-2012
# % Copyright (c) 2014 Sanchit Aggarwal. All rights reserved.
import os
import csv
#import numpy

data=[]
#file_path='car.csv'
#classposition=6
def Normalize_Data(file_path,classposition):
#Return the clean data for processing
    os.path.relpath(file_path,os.curdir)
    with open(file_path, 'rb') as f:
        	reader = csv.reader(f)
        	for row in reader:
                 data.append(row)
    #return the range of attributes for the csv
    attribute=[]
    for i in range(0,len(zip(*data))):
    	attribute.append(list(set(zip(*data)[i])))
    #print attribute
    #print data[692]
    for j in range(0,classposition):
        norm_fatcor=len(attribute[j])-1
        for i in range(0,len(data)):
            data[i][j]=round(float(attribute[j].index(data[i][j]))/norm_fatcor,2)
    
    for i in range(0,len(data)):
        data[i][classposition]=attribute[classposition].index(data[i][classposition])
    #data_point=numpy.array(data)
    #data_point=data
    return data#data_point#,attribute[classposition]
        
        
   

     
        
    
        




	
	
