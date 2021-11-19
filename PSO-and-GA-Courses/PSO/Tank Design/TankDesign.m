clc; clear; close all;
% Compute H & C as functions of R
R = 2:0.001:8;
H = 500./(pi*R.^2) - 2*R/3; % Height H
C = 300*2*pi*R.*H + 400*2*pi*R.^2; % Cost
% Plot cost vs radius
plot(R,C);
title('Tank Design');
xlabel('Radius R, m');
ylabel('Cost C, Dollars');
grid on;
% Compute and display minimum cost, corresponding H & R
[Cmin, kmin] = min(C);
Costmin = Cmin
Rmin = R(kmin)
Hmin = H(kmin)
