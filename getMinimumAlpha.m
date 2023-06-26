function alpha_k= linesearch_Secant(f,x0, machinePrecision)
 err= Inf;
 %Formula: x2=(x0*f(x1)-x1*f(x0))/(f(x1)-f(x0));

g0 = double(subs(gradient(f), x0(1)));
while err > machinePrecision
    g1 = double(subs(gradient(f), x0(2)));
    err = ((x0(2) - x0(1))/(g1 - g0))*g1;
    x0(1)= x0(2);
    x0(2) = x0(2)- err;
    g0 = g1;
end
alpha_k= x0(1);
end