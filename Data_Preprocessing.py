# % Course     : Machine Learning Homework Assigment 1
# % Description: Pre Processing of Data
# % Author     : Sanchit Aggarwal
# % Date       : 1-August-2014
# % Copyright (c) 2014 Sanchit Aggarwal. All rights reserved.

import csv
datafile = '../Mushroom_Dataset/agaricus-lepiota.data.txt'
data = open(datafile, 'r')

featurefile  = '../Mushroom_Dataset/features.txt'
feature = open(featurefile, 'r')

featuremap = []
a = 0
for f in feature:
    featuremap.append(f.strip().split(','))

processedData = []

for d in data:
    d = d.strip()
    dval = d.split(',')
    pd = []
    if dval[0] == 'e':
        pd.append(1)
    else:
        pd.append(0)
    for i in range(1, len(dval)):
        #print i
        for k in range(0, len(featuremap[i-1])):
            if dval[i] == featuremap[i-1][k]:
                pd.append(1)
            else:
                pd.append(0)

    processedData.append(pd)

with open('processedData.csv', 'w') as fp:
    a = csv.writer(fp, delimiter=',')
    a.writerows(processedData)