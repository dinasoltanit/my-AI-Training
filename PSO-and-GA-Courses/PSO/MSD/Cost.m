function J = Cost(x)

global NFE;
NFE = NFE + 1;

load Data;
m = x(1);
c = x(2);
k = x(3);
F = ones(293,1);
e = F-m*ddx-c*dx-k*x;
J = sse(e);



