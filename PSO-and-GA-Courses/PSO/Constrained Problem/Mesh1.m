clc; clear; close all;
x = -10:0.1:10;
y = -10:0.1:10;
[X,Y] = meshgrid(x,y);
J = (X-1.5).^2 + (Y-1.5).^2;
mesh(X,Y,J)
