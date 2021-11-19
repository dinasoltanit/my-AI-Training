function J = Cost(p)

global NFE;
NFE = NFE + 1;
x = p(1);
y = p(2);
J = x*sin(4*x)+1.1*y*sin(2*y);
