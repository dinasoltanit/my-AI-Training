function J = Cost(x)

global NFE;
NFE = NFE + 1;

J = abs(2*x-1);
