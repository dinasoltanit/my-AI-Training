function J = Cost(x)

global NFE;
NFE = NFE + 1;

y = x^3-x^2-4*x+4;

%% Maximization Problem
J = -y;
