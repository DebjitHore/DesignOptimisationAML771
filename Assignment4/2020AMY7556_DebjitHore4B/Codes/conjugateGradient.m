 %% f(x,y)=(1-x)^2+100(y-x^2)^2 Rosenbrock Function
clear all;
clc;
syms alpha;
X = [-2, 2]';
rosenbrockFunc= getFunc(X);
x0= [1,2];
g0= Gradient(rosenbrockFunc, X)';
d0=-g0;
numberIterations=1;
epsilon= 0.001;
X_vector= zeros(10,2);
disp (' Choose 1 for Fletcher Reeves updation of Beta, and 2 for Hestenes Stiefel Formula');
chooseBeta= input('Enter 1 or 2 ONLY');
beta= ['Fletcher Reeves', 'Hestenes Stiefel'];
 while numberIterations< 100
    X_vector(numberIterations,:)=X;
    g_temp= Gradient(rosenbrockFunc, X)';
    if abs(norm(g_temp))<epsilon
        break;
    end
    numberIterations= numberIterations+1; 
    phi_Alpha= vpa(X+alpha*d0,3);
    tempFunctionAlpha= vpa(getFunc(phi_Alpha));
    alpha_k= linesearch_Secant(tempFunctionAlpha, x0, epsilon);
    X=X+alpha_k*d0;
    rosenbrockFunc= getFunc(X);
    g0= Gradient(rosenbrockFunc, X)';  %New Value of Gradient at updated point.
    if abs(norm(g0))<epsilon
        break;
    end
    switch chooseBeta
        case 1
            beta_k =  (g0'*g0)/(g_temp'*g_temp);  %FLETCHER-REEVES FORMULA
        case 2
            beta_k = g0'*(g0-g_temp)/(d0'*(g0-g_temp));  %HESTENES STIEFEL FORMULA
    end
    if rem(numberIterations,6)== 0
        d0= -g0;
    else
        d0= -g0+beta_k*d0;
    end
    
 end
 
disp(sprintf('The final interval after %.4f iterations is %15.4E %15.4E', numberIterations, X(1), X(2)));
sizeVec=height(X_vector);
x= [1:sizeVec];
y= [1:sizeVec];
figure
quiver3(x',y',X_vector(:,1), X_vector(:,2));
title('Convergence of initial vector X after iterations');


 