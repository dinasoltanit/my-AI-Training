clc;clear;close all
%%
x=-10:0.1:10;
f1=@tansig;
plot(x,f1(x),'b')
hold on
f2=@logsig;
plot(x,f2(x),'r')
plot([min(x) max(x)],[0 0],'k:')
plot([0 0],[-1 1],'k:')