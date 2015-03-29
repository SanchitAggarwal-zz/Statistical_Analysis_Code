# -*- coding: utf-8 -*-
# -*- coding: utf-8 -*-
# % Course     : Statistical Methods in Artificial Intelligence
# % Description: KNN Classifier
# % Author     : Sanchit Aggarwal
# % Date       : 16-August-2012
# % Copyright (c) 2014 Sanchit Aggarwal. All rights reserved.

"""
Created on Thu Aug 16 19:23:21 2012

@author: sanchit"""

#from sys import argv
#filename=argv
#txt=open("C:\\"+filename)
#txt=open(filename)
#print txt.read()
#import urllib
import pylab
import random
import csv
import math
import os


data=[]
cleandata=[]
training_data=[]
testing_data=[]
classes=[]
min_distance=99999.00
#url of the dataset
#dataset={1:'http://archive.ics.uci.edu/ml/machine-learning-databases/iris/iris.data',
#        2:'http://archive.ics.uci.edu/ml/machine-learning-databases/yeast/yeast.data',
#         3:'http://archive.ics.uci.edu/ml/machine-learning-databases/letter-recognition/letter-recognition.data'
#}
dataset={1:'iris.csv',
         2:'yeast.csv',
         3:'scale.csv'
}
#position of the class name in dataset with stating index 0
classposition={1:4,
               2:9,
               3:0
}
#start position of attribute data for dataset excluding class name with stating index 0
startposition={1:0,
               2:1,
               3:1
}
#end position of the attribute for data set with stating index 0
endposition={1:4,
             2:9,
             3:4             
}

#to select the dataset
index=input('''Select the DataSet\n
1. Iris
2. yeast
3. balancescale--->''')

percentage=input('''Enter percentage for training data-->''')

#data=urllib.urlopen(dataset[index]).read().split('\n')
path=dataset[index]
os.path.relpath(path,os.curdir)
#print path
#os.path.join(path,dataset[index])
with open(path, 'rb') as f:
    reader = csv.reader(f)
    for row in reader:
        data.append(row)
#print data       
#print len(data)
    
for item in data:
    classes.append(item[classposition[index]])
#to identify the number of unique classes
classes=set(classes)
class_list=list(classes)
#print class_list
#print classes
#to randomize the input data
random.shuffle(data)

ConfusionMatrix = [[0 for x in xrange(len(classes))] for x in xrange(len(classes))] 
#partitioning into training and testing sets
training_len=int(percentage*len(data)/100)
training_data=data[0:training_len]
#training_data=data[0:75]
testing_data=data[training_len:len(data)]
#testing_data=data[75:150]
#print testing_data
#print len(testing_data)
#print training_data
#print len(training_data)
#print len(testing_data)
#print training_len+len(testing_data)
mean_accuracy=0.0
mean_standarddeviation=0.0
for test in range(1,11):
    accuracy=0.0
    sqr_accuracy=0.0
    for sample in testing_data:
        min_distance=99999.00
        #print sample
        sample_class=''
        for example in training_data:
            Eucledian_dist=0.0
            for i in range(startposition[index],endposition[index]):
                Eucledian_dist+=math.pow(float(example[i])-float(sample[i]),2)
            Eucledian_dist=math.sqrt(Eucledian_dist)
            if min_distance> Eucledian_dist:
                min_distance=Eucledian_dist
                sample_class=example[classposition[index]]
        #incrementing the confusion matrix
        actual_index=class_list.index(sample[classposition[index]])
        predicted_index=class_list.index(sample_class)
        ConfusionMatrix[actual_index][predicted_index]=ConfusionMatrix[actual_index][predicted_index]+1/test
        
    for m in range(0,len(classes)):
        accuracy+=ConfusionMatrix[m][m]
    accuracy/=len(testing_data)
    sqr_accuracy+=math.pow(accuracy,2)
    mean_accuracy=(mean_accuracy*(test-1)+accuracy)/test
    mean_standarddeviation=math.fabs(sqr_accuracy/test-math.pow(mean_accuracy,2))
    mean_standarddeviation=math.sqrt(mean_standarddeviation)
    
print '''
         Average Confusion Matrix %s \n 
         Average Accuracy Mean %f\n
         Average Standard Deviation %f'''%(ConfusionMatrix,mean_accuracy*100,mean_standarddeviation)
if index==1:
    for sample in testing_data:
        if(sample[4]==class_list[0]):
            pylab.plot(sample[1],sample[3],'ro')
        if(sample[4]==class_list[1]):
            pylab.plot(sample[1],sample[3],'bo')
        if(sample[4]==class_list[2]):
            pylab.plot(sample[1],sample[3],'go')
    X=0.01
    Y=0.01
    for x in range(1,450):
        for y in range(1,250):
            min_distance=99999.00
            #print sample
            cor_x=X*x+2.0
            cor_y=Y*y+0.0
            sample_class=''
            for example in training_data:
                Eucledian_dist=0.0
                Eucledian_dist+=math.pow(float(example[1])-cor_x,2)+math.pow(float(example[3])-cor_y,2)
                Eucledian_dist=math.sqrt(Eucledian_dist)
                if min_distance> Eucledian_dist:
                    min_distance=Eucledian_dist
                    sample_class=example[4]
            if(sample_class==class_list[0]):
                pylab.plot(cor_x,cor_y,'ro')
            if(sample_class==class_list[1]):
                pylab.plot(cor_x,cor_y,'bo')
            if(sample_class==class_list[2]):
                pylab.plot(cor_x,cor_y,'go')
pylab.xlabel('training');
pylab.ylabel('testing');
pylab.title('KNN classification');
pylab.show()
