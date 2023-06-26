%  Performs golden section search  on the function func. 
%  No more than N function evaluation are done. N is evaluated by given uncertainty "(b-a)(0.61803)^N <= eps"
%  When b-a < eps, the iteration stops.
%% Input value
a = input('Enter the lower limit, a =  ');
b = input('Enter the higher limit, b = ');
eps = input('Enter the value of epsilon, eps = ');                                                               

% To check the unimodality
xx = 1:0.01:2;
[f] = func(xx);
plot(xx,f); 

%%%% Optimization code
N = (log(eps)-log(b-a))/(log(0.61803));   % Decide number of iterations
r = (3-sqrt(5))/2;                        % (rho) evaluation
a1 = a + (r)*(b-a);
fa1 = func(a1);
b1 = a + (1-r)*(b-a);
fb1 = func(b1);

fprintf('----------------------------------------------------------------------------\n');
fprintf('     a          b         a1        b1        f(a1)       f(b1)      b - a\n');
fprintf('----------------------------------------------------------------------------\n');
fprintf('%.4e %.4e %.4e %.4e %.4e %.4e %.4e\n', a, b, a1, b1, fa1, fb1, b-a);
for i = 1:N+1
   if fa1 < fb1
      b = b1;
      b1 = a1;
      fb1 = fa1;
      a1 = a + r*(b-a);
      fa1 = func(a1);
   else
      a = a1;
      a1 = b1;
      fa1 = fb1;
      b1 = a + (1-r)*(b-a);
      fb1 = func(b1);
   end
   fprintf('%.4e %.4e %.4e %.4e %.4e %.4e %.4e\n', a, b, a1, b1, fa1, fb1, b-a);
   if (abs(b-a) < eps)
%       fprintf('succeeded after %d steps\n', i);
      if fa1<fb1
        fprintf('Function minima obtained at x* = %f for given epsilon is %f\n', a1, fa1);
      else
        fprintf('Function minima obtained at x* = %f for given epsilon is %f\n', b1, fb1);
      end
      break;
   end
end

function y = func(x)
%y=x.^2 + 4.*cos(x);           % 1st ques
y = 8.*exp(1-x) + 7.*log(x);    % 2nd ques
end