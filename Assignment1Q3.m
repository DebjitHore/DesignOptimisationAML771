clear all; close all;
disp('========================================');
disp('     GRADIENT by Finite Differences Assignment Q3     ');
disp('     AML 771: Design Optimization and Decision Theory   ');
disp('     Student: Debjit Hore       ');
disp('========================================');

epsilon=0.01;
alpha=0;
X=[2, 1]'; D=[-1, 0]';
fAlpha= GETALPHA(alpha);
fAlphaEpsilon=GETALPHA(alpha+epsilon);
directionalDerivative= (fAlphaEpsilon-fAlpha)/epsilon;
disp(sprintf('The Directional Derivate of Given function through forward difference is %15.4E ',directionalDerivative));


disp('COMPARING WITH ANALYTICAL VALUE OF DIRECTIONAL DERIVATIVE');

[F0, gradientf]= GETFUN(X);
DD2= gradientf'*D;

disp(sprintf('The Directional Derivate calculated through analytical forumla is %15.4E ',DD2));








function[F0, gradientf]=GETFUN(X)
    syms x1 x2 ;
    f= 100*(x2-x1^2)^2+(1-x1)^2;
    gradf=gradient(f);
    x1=X(1); x2=X(2);
    gradientf= subs(gradf);
    F0= subs(f);
end
function [fAlpha]= GETALPHA(alpha)
    fAlpha= 100*(1-(2-alpha)^2)^2+(1-(2-alpha))^2;
end


