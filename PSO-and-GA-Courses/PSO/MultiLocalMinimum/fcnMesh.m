clc; clear; close all;
x = 0:0.1:10;
y = 0:0.1:10;
[X,Y] = meshgrid(x,y);
Z = X.*sin(4*X)+1.1*Y.*sin(2*Y);
mesh(X,Y,Z)
Z_min = min(min(Z))
