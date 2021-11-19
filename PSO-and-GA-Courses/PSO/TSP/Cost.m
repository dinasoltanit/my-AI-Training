function [L, Tour] = Cost(PrtPos)

global NFE;
NFE = NFE + 1;

global x y;
N = length(x);

D = zeros(N,N);
for i = 1:N-1
    for j = i:N
        D(i,j) = sqrt((x(i)-x(j))^2+(y(i)-y(j))^2);
        D(j,i) = D(i,j);
    end
end

Tour(1) = 1;
[~, Tourp] = sort(PrtPos);
Tour(2:length(PrtPos)+1) = Tourp+1;
Tour = [Tour Tour(1)];

L = 0;
for k = 1:N
    i = Tour(k);
    if k < N
        j = Tour(k+1);
    else
        j = Tour(1);
    end
    L = L + D(i,j);
end
