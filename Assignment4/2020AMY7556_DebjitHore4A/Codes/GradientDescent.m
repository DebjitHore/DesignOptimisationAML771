%%
clear all; clc;
syms alpha
X= [0.8, -0.25]';
X_secant= X;
X_golden= X;
x0= [2;5]; 
epsilon= 0.0001;
F_Secant= getFunc(X_secant);

%%
X_secantVector=zeros(10,2);
X_goldenVector= zeros(10,2);
NFV=1;

while 1                         
    syms alpha
    X_secantVector(NFV,:)= X_secant;
    NFV = NFV + 1;
    gradf = Gradient(F_Secant, X_secant);       
    stoppingCriteria = norm(gradf);        
    temp = vpa(X_secant-alpha*gradf',3);  
    f = vpa(getFunc(temp),3);       
    alphak = linesearch_Secant(f, x0, epsilon); 
    X_secant = X_secant - alphak*gradf';  
    F_newSecant= getFunc(X_secant);
    gradf = Gradient(F_newSecant, X_secant);       
    F_Secant= F_newSecant;
if abs(norm(gradf) - stoppingCriteria) < epsilon
    break                       
end

end 

NFS=1;
while 1
    if NFS == 1
    X_goldenVector(NFV,:)= X_golden;
    F= getFunc(X); %Function value at initial guess
    gradf= Gradient(F, X);%Numerical Gradient computation of our function.
    d= -gradf;
    x0= [0;1]; 
    epsilon= 0.0001;
    temp = vpa(X+alpha*d',3);
    f=vpa(getFunc(temp),3);
    alphak_Golden= getGoldenSection(f, x0, epsilon);
    X_golden= X_golden+alphak_Golden* d';
    F_newGolden= getFunc(X_golden);
    NFS=NFS+1;
    else

    FGolden= F_newGolden;
    gradf= Gradient(FGolden,X_golden);
    d= - gradf;
    temp = vpa(X_golden-alpha*gradf',3);
    f=vpa(getFunc(temp),3);
    alphak_Golden= getGoldenSection(f, x0, epsilon);
    X_golden= X_golden+	alphak_Golden* d';
    F_newGolden= getFunc(X_golden);
    NFS= NFS+1;
    if abs(norm(gradf)-stoppingCriteria)<epsilon
        break
    end
    end
end

sizeVecGolden=height(X_goldenVector);
sizeVecSecant=height(X_secantVector);
x_secant= [1:sizeVecSecant];
y_secant= [1:sizeVecSecant];
x_golden= [1:sizeVecGolden];
y_golden= [1:sizeVecGolden];


disp(sprintf('The final interval on using line search "Secant" method is %15.4E %15.4E', X_secant(1), X_secant(2)));
disp(sprintf('The number of iterations by "Secant" method is %.4f', NFV));
disp(sprintf('The final interval on using line search "Golden" method is %15.4E %15.4E', X_golden(1), X_golden(2)));
disp(sprintf('The number of iterations by "Golden" method is %.4f', NFS));

subplot(1,2,1)
quiver3(x_secant',y_secant',X_secantVector(:,1), X_secantVector(:,2));
title('Plot of convergence for initial X vector Secant Method')
subplot(1,2,2)
quiver3(x_golden',y_golden',X_goldenVector(:,1), X_goldenVector(:,2));
title('Plot of convergence for initial X vector Golden Method')
sgtitle('Convergence Plot')