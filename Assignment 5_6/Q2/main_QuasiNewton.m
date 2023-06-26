%%
clear all;
clc;
syms alpha;
X = [-2; 2];
g0= grad(X);
H0= eye(height(g0));
epsilon= 10e-5;
%%
while norm(g0)>epsilon
numberIterations=1;
X_vector= zeros(10,2);
disp (' Choose 1 for Rank1 updation of Beta, and 2 for DFP and 3 for BFGS updation of inverse Hessian');
chooseHessUpdation= input('Enter 1, 2 OR 3 ONLY');

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
    switch chooseHessUpdation
        case 1
            H_temp=H0+((delta_X-H0*delta_g)*(delta_X-H0*delta_g)')/(delta_g'*(delta_X-H0*delta_g));  %Rank 1 
        case 2
            H_temp= H0+ ((delta_X*delta_X')/(delta_X'*delta_g)-((H0*delta_g)*(H0*delta_g)')/(delta_g'*H0*delta_g));  %DFP Algorithm
        case 3
            H_temp= H0+ (1+(delta_g'*H0*delta_g)/(delta_g'*delta_X)*((delta_X*delta_X')/(delta_X'*delta_g)))-((H0*delta_g*delta_X')+(H0*delta_g*delta_X')')/(delta_g'*delta_X); %BFGS updation.
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
end


disp(sprintf('The final interval after %.4f iterations is %15.4E %15.4E', numberIterations, X(1), X(2)));


 