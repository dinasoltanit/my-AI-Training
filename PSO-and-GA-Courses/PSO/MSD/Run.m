clc; clear; close all;
global m c k F;
m = 1;
c = 10;
k = 200;
F = 1;
x0 = [0.1 0.2];
t = [0 10];
[Time,X] = ode45(@MSD,t,x0);
x = X(:,1);
dx = X(:,2);
ddx = (F-c*dx-k*x)/m;
plot(Time,X(:,1),'linewidth',3)
hold on;
plot(Time,X(:,2),'r--','linewidth',3)
plot(Time,ddx,'g--','linewidth',3)
legend('x','dx','ddx')