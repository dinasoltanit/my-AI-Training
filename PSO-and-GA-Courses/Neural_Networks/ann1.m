% Feed-Forward Networks

clc;clear;close all
%% Inputs and Targets

x = 0:0.3:2*pi; %Inputs
y = sin(x); %Targets

%% Create a Fitting Network
hiddenLayerSize = 3;
net = fitnet(hiddenLayerSize);

% Train the Network
net = train(net,x,y);

% Test the Network
yhat = net(x);

e=abs(y-yhat);

plot(e)
