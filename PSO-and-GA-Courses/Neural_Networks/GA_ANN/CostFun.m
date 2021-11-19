function [J , Info]=CostFun(M)

global inputs targets

    w11=M(1); w21=M(2);
    b11=M(3);  b21=M(4);
    
    w12=M(5); w22=M(6);
    b12=M(7);
    
    
    W1=[w11 w21]';
    b1=[b11 b21]';
    
    W2=[w12 w22];
    b2=b12;
    
    x=inputs;
    yhat=W2*tansig(W1*x+b1)+b2;
    
    
    y=targets;
    
    e=y-yhat;
    
    J=mean(e.^2); %MSE
    
    Info.x=inputs;
    Info.y=targets;
    Info.W1=W1;
    Info.b1=b1;
    Info.W2=W2;
    Info.b2=b2;
    Info.yhat=yhat;
    Info.e=e;
    Info.mse=J;
    
    


end