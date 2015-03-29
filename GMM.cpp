// Course     : Machine Learning Homework Assigment 3
// Description: Gaussian Mixture Models on MNSIT Data.
// Author     : Sanchit Aggarwal
// Date       : 2-September-2014 03:40 P.M.
// Copyright (c) 2014 Sanchit Aggarwal. All rights reserved.

#include <stdio.h>
#include <iostream>
#include <opencv2/opencv.hpp>

using namespace cv;
using namespace std;

Mat dat[10];

void read_data(char *feature_file, char *sizes, Mat &train, Mat &label)
{
    FILE *feature_fp = fopen(feature_file, "r");
    FILE *size_fp = fopen(sizes,"r");
    unsigned char feature[10000][784];
    for(int i=0;i<10000;i++)
    {
        for(int j=0;j<784;j++)
        {
            fscanf(feature_fp, "%hhu", &feature[i][j]);
        }
    }
    fclose(feature_fp);
    train = Mat(10000,784,CV_8UC1, &feature);
    
    for(int i=0;i<10;i++)
    {
        int length;
        fscanf(size_fp,"%d", &length);
        Mat l = i*Mat::ones(length, 1, CV_8UC1);
        label.push_back(l);
    }
    fclose(size_fp);
}

int main(int argc, char **argv)
{
    Mat data, label;
    Mat train, train_label;
    Mat test, test_label;
    
    read_data(argv[1], argv[2], data, label);
    printf("\nTrain size : %dx%d\n", data.rows, data.cols);
    
    data.convertTo(data, CV_32F);
    
    label.convertTo(label, CV_32F);
    
    
    for(int i=0;i<data.rows;i++)
    {
        if(i%2==0)
        {
            train.push_back(data.row(i).clone());
            train_label.push_back(label.row(i).clone());
        }
        else
        {
            test.push_back(data.row(i).clone());
            test_label.push_back(label.row(i).clone());
        }
    }
    
    for(int i=0;i<train.rows;i++)
    {
        dat[(int)train_label.at<float>(i,0)].push_back(train.row(i).clone());
    }
    
    EM em[10];
    
    
    for(int i=0;i<10;i++)
    {
        printf("\nStart training : %d -> %dx%d", i, dat[i].rows, dat[i].cols);
        printf("\n");
        
        em[i] = EM(1, EM::COV_MAT_SPHERICAL, TermCriteria(TermCriteria::COUNT, 10, FLT_EPSILON));
        em[i].train(dat[i]);
        
        Mat m = em[i].get<Mat>("means");
        for(int j =0; j<m.rows;j++)
        {
            Mat img = Mat(28,28,CV_32FC1);
        
            img = (m.row(j).clone()).reshape(1,28);
            normalize(img, img, 0,255,NORM_MINMAX);
            img.convertTo(img, CV_8UC1);
            resize(img, img, Size(280,280));
            imshow("img", img);
            char name[100];
            sprintf(name, "mean%d_%d.png",i,j);
            imwrite(name, img);
        }
        
    }
    
    
    printf("\nStart testing");
    int correct =0;
    int confusion[10][10]={0};
    
    
    for(int i=0;i<test.rows;i++)
    {
        int max_index = -1;
        double max = -1;
        for(int j=0;j<10;j++)
        {
            double likelihood = em[j].predict(test.row(i).clone())[0];
            
            if(likelihood > max)
            {
                max = likelihood;
                max_index = j;
            }
        }
        
        int response = max_index;
        if((int)response == (int)test_label.at<float>(i,0))
            correct++;
        confusion[(int)response][(int)test_label.at<float>(i,0)]++;
    }
    
    printf("\nAccuracy : %f\n", (float)correct/test.rows);
    
    
    
    for(int i=0;i<10;i++)
    {
        for(int j=0;j<10;j++)
        {
            printf("%d\t", confusion[i][j]);
        }
        printf("\n");
    }


    
    return 0;
}
