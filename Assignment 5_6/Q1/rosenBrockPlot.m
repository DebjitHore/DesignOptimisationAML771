clear all;clc; 
y=linspace(0,2,50);
x=linspace(-1.5,1.5,50);
[X,Y]= meshgrid(x,y);
 %%
subplot(1,2,1)

%rosenBrockFunction= @(x,y)(1-x).^2+100.*(y-x.^2).^2; %Rosenbrock Function
fval = (1-X).^2+100*(Y-X.^2).^2;
surf(X,Y, fval);
title('Function Values at different choices of x and y');


 %%
 
subplot(1,2,2)
contour3(X,Y, fval,50);
shading interp
title('3D contour plot of Rosenbrock Function');
