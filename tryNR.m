load ’beetle.dat’; % load data
m=length(beetle(:,1)) % count the rows in the data matrix
x=[]; % create empty vectors
y=[];
for j=1:m % expand group data into individual data
x=[x,beetle(j,1)*ones(1,beetle(j,2))];
y=[y,ones(1,beetle(j,3)),zeros(1,beetle(j,2)-beetle(j,3))];
end
beetle2=[x;y]’;
% Next, specify starting points for iteration on parameter values:
beta0 = [0;
0]
% Finally, call the function NR_logistic and use its output
[betaml,Jbar] = NR_logistic(beetle2,beta0)
covmat = inv(Jbar)
stderr = sqrt(diag(covmat))


function [beta,J_bar] = NR_logistic(data,beta_start)
    x=data(:,1); % x is first column of data
    y=data(:,2); % y is second column of data
    n=length(x)
    diff = 1; beta = beta_start; % initial values
    while diff>0.0001 % convergence criterion
        beta_old = beta;
        p = exp(beta(1)+beta(2)*x)./(1+exp(beta(1)+beta(2)*x));
        l = sum(y.*log(p)+(1-y).*log(1-p))
        s = [sum(y-p); % scoring function
        sum((y-p).*x)];
        J_bar = [sum(p.*(1-p)) sum(p.*(1-p).*x); % information matrix
        sum(p.*(1-p).*x) sum(p.*(1-p).*x.*x)]
        beta = beta_old + J_bar\s % new value of beta
        diff = sum(abs(beta-beta_old)); % sum of absolute differences
    end

data(1).training = train0;
    data(2).training = train1;
    data(3).training = train2;
    data(4).training = train3;
    data(5).training = train4;
    data(6).training = train5;
    data(7).training = train6;
    data(8).training = train7;
    data(9).training = train8;
    data(10).training = train9;
    data(1).testing = test0;
    data(2).testing = test1;
    data(3).testing = test2;
    data(4).testing = test3;
    data(5).testing = test4;
    data(6).testing = test5;
    data(7).testing = test6;
    data(8).testing = test7;
    data(9).testing = test8;
    data(10).testing = test9;
    data(1).name = '0';
    data(2).name = '1';
    data(3).name = '2';
    data(4).name = '3';
    data(5).name = '4';
    data(6).name = '5';
    data(7).name = '6';
    data(8).name = '7';
    data(9).name = '8';
    data(10).name = '9';
