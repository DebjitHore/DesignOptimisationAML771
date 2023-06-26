x_old= 0;
x_new= 0.001;
f= @(x)2*(2.008+1.984*x-3)*1.984+16*(-5.062+0.0038*x+5)^3*0.0038; 
iter=0
while abs(x_new-x_old)>0.0001
    temp_x= (f(x_new)*x_old-f(x_old)*x_new)/(f(x_new)-f(x_old));
    x_old=x_new;
    x_new=temp_x;
    iter=iter+1;
end
