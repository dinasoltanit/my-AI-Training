function plotresults(y,yhat,name)

figure;
subplot(221)
plot(y,'b')
hold on
plot(yhat,'r--')
legend('y','yhat')
title(name)
grid

subplot(222)
plot(y,yhat,'ko')
hold on
xmin=min(min(y),min(yhat));
xmax=max(max(y),max(yhat));
plot([xmin xmax],[xmin xmax],'b')
C=corr(y',yhat');
title(['R = ' num2str(C)])

subplot(223)
e=y-yhat;
plot(e,'b')
legend('Error')

MSE=mean(e.^2);
RMSE=sqrt(MSE);

title(['MSE = ' num2str(MSE) , ' , RMSE = ' num2str(RMSE)])


subplot(224)
histfit(e,40)
mu=mean(e);
sigma=std(e);

title(['\mu = ' num2str(mu) , ' , \sigma = ' num2str(sigma)])




end