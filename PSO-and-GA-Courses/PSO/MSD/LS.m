clc; clear;
load Data;
Phi = [x dx ddx];
Y = F*ones(293,1);
theta = inv(Phi'*Phi)*Phi'*Y