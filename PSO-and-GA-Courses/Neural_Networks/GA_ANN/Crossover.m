function [o1, o2]=Crossover(p1,p2,VarMin,VarMax) %Arithmatic Crossover

global Gamma

alpha=unifrnd(-Gamma,1+Gamma,size(p1)); %alpha=rand(size(x1)); %Mask variables

o1=alpha.*p1+(1-alpha).*p2;
o2=alpha.*p2+(1-alpha).*p1;

o1=min(max(o1,VarMin),VarMax);
o2=min(max(o2,VarMin),VarMax);

end