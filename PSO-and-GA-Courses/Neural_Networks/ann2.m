clc;clear;close all
%%

x=linspace(0,2*pi,20);
y=sin(x);

%%
HLS=3;
trainfcn='trainlm';
net=fitnet(HLS,trainfcn);

net.divideParam.trainRatio=80/100;
net.divideParam.valRatio=10/100;
net.divideParam.testRatio=10/100;

% Train the network
[net,tr]=train(net,x,y);

% Output
yhat=net(x);

% Total Error
e=y-yhat; % e=gsubtract(y,yhat);
MSE=mean(e.^2);
RMSE=sqrt(MSE);


%
trainInd=tr.trainInd;
valInd=tr.valInd;
testInd=tr.testInd;

x_train=x(trainInd);
x_val=x(valInd);
x_test=x(testInd);

y_train=y(trainInd);
y_val=y(valInd);
y_test=y(testInd);

yhat_train=yhat(trainInd);
yhat_val=yhat(valInd);
yhat_test=yhat(testInd);

plotresults(y,yhat,'All data')

plotresults(y_train,yhat_train,'Train data')

plotresults(y_val,yhat_val,'Validation data')

plotresults(y_test,yhat_test,'Test data')
