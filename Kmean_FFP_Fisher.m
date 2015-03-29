% Course     : Machine Learning Homework Assigment 2
% Description: K-means Clustering and Fisher Projection
% Author     : Sanchit Aggarwal
% Date       : 15-September-2014
% Copyright (c) 2014 Sanchit Aggarwal. All rights reserved.

load('../Dataset/MNIST_Dataset/mnist_all.mat');
train=[train0; train1; train2; train3; train4; train5; train6; train7; train8; train9 ];

global_mean=mean(train);


local_mean = zeros(10,784);
local_cov= zeros(10,784,784);
c_size=zeros(1,10);

for i=0:9
    data=eval(['train' num2str(i)]);
    
    local_mean(i+1,:)=mean(data);    
    local_cov(i+1,:,:)= cov(double(data));
    c_size(i+1)=size(data,1);
    clear data;
end

% sb=between class
% sw=Within  class
sb=zeros(784,784);
sw=zeros(784,784);%zeros(size(train,1));

for i=1:10
    sb=sb + c_size(i)*(local_mean(i)-global_mean)*(local_mean(i)-global_mean)';
    sw=sw + local_cov(i);
end

sw_inv=inv(sw);
f=sw_inv*sb;
    

 cv=cov(double(f));
 cv(isnan(cv))=0;
 [e_vec,e_val]  = eig(cv);
 [d,q]=sort(-diag(e_val));	
 pro_lda=double(train)*e_vec(:,q(1:9));
 
 Purity=zeros(5,1);
    error=zeros(5,1);
 it=1;
 for k=10:5:10
     ffp = cluster_p(pro_lda,k);
     [IDX,C,sumd,D] = kmeans(double(pro_lda),k,'start', ffp,'MaxIter',2);
     
     %for j=1:60000ans_7
      %      sum(it,1)=sum(it,1)+D(j,IDX(j));
     %end
     
     for n=1:k
        c_image=zeros(3,3);
        c_image=reshape(C(n,:),[3 3]);
        imwrite(c_image,[num2str(n) 'q7_' num2str(k) '.png']);
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
 
    
