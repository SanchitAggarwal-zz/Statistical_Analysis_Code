% Course     : Machine Learning Homework Assigment 2
% Description: K Means Clustering using FFP on PCA
% Author     : Sanchit Aggarwal
% Date       : 15-September-2014 10:52 P.M.
% Copyright (c) 2014 Sanchit Aggarwal. All rights reserved.

clear all
clc
load '../Dataset/MNIST_Dataset/mnist_all.mat'
train = cat(1, train0, train1, train2, train3, train4, train5, train6, train7, train8, train9);

 Purity=zeros(5,1);
    error=zeros(5,1);
 it=1;
 for k=5:5:25
     ffp = cluster_p(train,k);
     [IDX,C,sumd,D] = kmeans(double(train),k,'start', ffp);
     
     %for j=1:60000
      %      sum(it,1)=sum(it,1)+D(j,IDX(j));
     %end
     
     for n=1:k
        c_image=zeros(28,28);
        c_image=reshape(C(n,:),[28 28]);
        imwrite(c_image,[num2str(n) 'q6_' num2str(k) '.png']);
     end
    
    
     error(it,1)=sum(sumd);
     
      maxi=zeros(k,1);
       
       
        sump=0;
        c=zeros(10,1);
        iter=0;
        for i=1:k         
            iter= iter + size(train0,1);
            for p=1:iter;
                if IDX(p)==i
                    c(1)=c(1)+1;
                end
            end
            iter_s=iter ;
            iter= iter + size(train1,1);
            for p=[iter_s+1:1:iter]
                if IDX(p)==i
                    c(2)=c(2)+1;
                end
            end
            iter_s=iter ;
            iter= iter + size(train2,1);
            for p=[iter_s+1:1:iter]
                if IDX(p)==i
                    c(3)=c(3)+1;
                end
            end
            iter_s=iter ;
            iter= iter + size(train3,1);
            for p=[iter_s+1:1:iter]
                if IDX(p)==i
                    c(4)=c(4)+1;
                end
            end
            iter_s=iter ;
            iter= iter + size(train4,1);
            for p=[iter_s+1:1:iter]
                if IDX(p)==i
                    c(5)=c(5)+1;
                end
            end
            iter_s=iter ;
            iter= iter + size(train5,1);
            for p=[iter_s+1:1:iter]
                if IDX(p)==i
                    c(6)=c(6)+1;
                end
            end
            iter_s=iter ;
            iter= iter + size(train6,1);
            for p=[iter_s+1:1:iter]
                if IDX(p)==i
                    c(7)=c(7)+1;
                end
            end
            iter_s=iter ;
            iter= iter + size(train7,1);
            for p=[iter_s+1:1:iter]
                if IDX(p)==i
                    c(8)=c(8)+1;
                end
            end
            iter_s=iter ;
            iter= iter + size(train8,1);
            for p=[iter_s+1:1:iter]
                if IDX(p)==i
                    c(9)=c(9)+1;
                end
            end
            iter_s=iter ;
            iter= iter + size(train9,1);
            for p=[iter_s+1:1:iter]
                if IDX(p)==i
                    c(10)=c(10)+1;
                end
            end
            iter
            iter=0;
           
            maxi(i)=max(c)
            
            sump=sump+maxi(i);
             c=zeros(10,1)
        end
        
        [m n]=size(train);
        Purity(it,1)=sump/m;
        it=it+1
 end