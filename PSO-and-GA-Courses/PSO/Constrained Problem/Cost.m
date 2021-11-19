function J = Cost(x)

global NFE;
NFE = NFE + 1;

J = (x(1)-1.5)^2 + (x(2)-1.5)^2;

% Constraints: x(1)+x(2)-3<=0 and x(1)>=2


if x(1)+x(2)-3>0 | x(1)<2
    J = 1e10;
end


