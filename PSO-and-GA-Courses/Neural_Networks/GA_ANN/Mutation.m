function o=Mutation(x,VarMin,VarMax) % (Gaussian) Normal (Probability) Mutation

global mu

nVar=numel(x);

nMu=ceil(mu*nVar);

j=randsample(nVar,nMu);

o=x;

sigma=0.1*(VarMax-VarMin);  % Mutation Step Size
o(j)=x(j)+sigma*randn; %randn : Standard Normal Distributaion if randn-->unifrnd : Uniform Probobility Mutation

o=min(max(o,VarMin),VarMax);

end