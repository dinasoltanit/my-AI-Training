clc; clear;
close all
dbstop if error
pause(1)
tic
global inputs targets
global Gamma mu
%% Problem Definition
inputs=[-2 -1.5 -1 -0.5 0 0.5 1 1.5 2];
targets=[0 0.0761 0.2929 0.6173 1 1.3827 1.7071 1.9239 2];


MaxIteration=1000;

npop=50;

Fc=0.75;
nC=2*round(Fc*npop/2);
Gamma=0.1;

Fm=0.1;
nM=round(Fm*npop);
mu=0.1;

%%
CostFun=@(M) CostFun(M);      % Cost Function

nVar=7;             % Number of Decision Variables
VarSize=[1 nVar];

VarMin=-5;
VarMax=+5;
%% Initail Population
tic
% Initail Population
empty_ind.M=[];
empty_ind.Cost=[];
empty_ind.Info=[];

pop=repmat(empty_ind,npop,1);

for ii=1:npop
    
    pop(ii).M=unifrnd(VarMin,VarMax,VarSize);
    
    [pop(ii).Cost , pop(ii).Info] = CostFun(pop(ii).M);
    
end

%% Train with Genetic Algorithm Method


for iter=1:MaxIteration
    
    popc=repmat(empty_ind,nC/2,2);
    
    for k=1:nC/2
        
        in1=randi([1 npop]);
        in2=randi([1 npop]);
        
        p1=pop(in1);
        p2=pop(in2);
        
        [o1,o2]=Crossover(p1.M,p2.M,VarMin,VarMax);
        o1=min(max(o1,VarMin),VarMax);
        o2=min(max(o2,VarMin),VarMax);
        popc(k,1).M=o1;
        popc(k,2).M=o2;
        
        [popc(k,1).Cost , popc(k,1).Info] = CostFun(popc(k,1).M);
        [popc(k,2).Cost , popc(k,2).Info] = CostFun(popc(k,2).M);
        
    end
    
    popc=popc(:);
    
    
    %Mutation
    
    popm=repmat(empty_ind,nM,1);
    
    for jj=1:nM
        
        in1=randi([1 npop]);
        P=pop(in1);
        
        popm(jj).M=Mutation(P.M,VarMin,VarMax);
        popm(jj).M=min(max(popm(jj).M,VarMin),VarMax);
        
        [popm(jj).Cost , popm(jj).Info] = CostFun(popm(jj).M);
        
    end
    
    
    % Merge population
    pop=[pop
        popc
        popm];
    
    
    % Sort
    
    J=[pop.Cost];
    [J,indexSortedJ]=sort(J);
    pop=pop(indexSortedJ);
    
    
    %Truncation
    pop=pop(1:npop); 
    J=J(1:npop);
    
    %store best solution ever found
    BestSol=pop(1);
    
    
    fprintf('Iter %d : BestSol = %f \n',iter,BestSol.Cost)
    
end

time=toc;

%% Train with Levenberg-Marquardt Method

x=inputs;
y=targets;

HLS=2;
trainfcn='trainlm';
net=fitnet(HLS,trainfcn);

net.divideParam.trainRatio=70/100;
net.divideParam.valRatio=15/100;
net.divideParam.testRatio=15/100;

% Train the network
[net,tr]=train(net,x,y);

% Output
yhat1=net(x);

% Total Error
e1=y-yhat1; % e=gsubtract(y,yhat);

%% Plot results

figure;

subplot(121)
plot(x,y,'b-','LineWidth',1) % targets
hold on
plot(x,yhat1,'r--','LineWidth',1); % Output of Levenberg-Marquardt
grid
yhat2=BestSol.Info.yhat;

plot(x,yhat2,'k-.','LineWidth',1) % Output of GA
legend('Target','Levenberg','GA')
xlabel('Input')
ylabel('Output')

e2=BestSol.Info.e;
subplot(122)
plot(e1,'r--')
hold on
plot(e2,'k-.')

ylabel('Error')


XTick=get(gca,'XTick');


plot([min(XTick) max(XTick)],[min(e1) min(e1)],'r')
plot([min(XTick) max(XTick)],[min(e2) min(e2)],'k')

plot([min(XTick) max(XTick)],[max(e1) max(e1)],'r')
plot([min(XTick) max(XTick)],[max(e2) max(e2)],'k')

legend('Levenberg','GA','Bounds of Levenberg Error','Bounds of GA Error')

title({['Levenberg MSE: ' num2str(mean(e1.^2))],...
    ['GA MSE: ' num2str(mean(e2.^2))]})
grid

