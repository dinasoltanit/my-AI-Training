function J = Cost(R)

global NFE;
NFE = NFE + 1;

H = 500/(pi*R^2) - 2*R/3; % Height H
J = 300*2*pi*R*H + 400*2*pi*R^2; % Cost