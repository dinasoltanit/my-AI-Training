function dx = MSD(t,x)
global m c k F;
dx = [x(2); (F-k*x(1)-c*x(2))/m];