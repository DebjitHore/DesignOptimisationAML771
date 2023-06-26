clear all;
clc;
%%
f= @(x1,x2) (x1.^4)/4+(x2.^2)/2-x1.*x2+x1-x2 ;
[X1,X2]= meshgrid(-2:0.01:2, -2:0.01:4);
values= [-0.72; -0.6; -0.2; 0.5];
iteration=1;
z= f(X1,X2);


%%


%%
syms alpha;

disp(sprintf('Choose 1 for starting point [0,0] and 2 for starting point [1.5,1]'));
chooseInitialPoint= input('Enter 1 or 2 ONLY');
switch chooseInitialPoint
    case 1
        X=[0;0];
    case 2
        X=[1.5;1];
end
g0= grad(X);
H0= eye(height(g0));
epsilon= 10e-5;
%%
while norm(g0)>epsilon
numberIterations=1;
X_vector= zeros(10,2);
while numberIterations< 100
    d=-H0*g0;
    X_vector(numberIterations,:)=X;
    g_temp= grad(X);
    if abs(norm(g_temp))<epsilon
        break;
    end
    numberIterations= numberIterations+1; 
    alpha_k= linesearch_secant('grad', X, d);
    X_new=X+alpha_k*d;
    g0_new= grad(X_new);  %New Value of Gradient at updated point.
    delta_X= X_new-X;
    delta_g= g0_new-g0;
    H_temp= H0+ ((delta_X*delta_X')/(delta_X'*delta_g)-((H0*delta_g)*(H0*delta_g)')/(delta_g'*H0*delta_g));  %DFP Algorithm
    end
    g0=g0_new;
    X=X_new;
    H0=H_temp;
    if rem(numberIterations,6)== 0
        d= -g0;
    else
        d= -H0*g0;
    end
    
 end



disp(sprintf('The final interval after %.4f iterations is %15.4E %15.4E', numberIterations, X(1), X(2)));
disp('The local minimiser is being plotted on the contour, depending on choice of initial choice');
%%
figure; hold on;
contour(X1,X2,z, values);
title('Function Level Set with Minimum value point corresponding to initial choice.');
%PLOTTING MINIMUM POINTS ON CONTOUR
plot(X(1), X(2), 'ok', 'MarkerFaceColor', 'k');
