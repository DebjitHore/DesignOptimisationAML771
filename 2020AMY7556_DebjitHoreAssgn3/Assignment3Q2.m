    function [] = getGoldenSection()
    close all; clear all;

    %Initial uncertainty range [A, B]
    A = input('Left point of initial range,  a0: '); %Passed to function GOLDIN as X1
    B = input('Right point of initial range, b0: '); %Passed to function GOLDIN as X2
    DLT = input('  Give Final Interval Length DLT/ Final uncertainty range: ');
    NR = 0;
    NS = NR + 1;
    [X, F, A, B, NFV] = GOLDIN(A, B, NS, DLT);
    disp(blanks(1));    
    disp(sprintf('Number of Function Evaluations = %d\n', NFV));
    disp(' Value of X closest to minimiser, Value of function F at X = ');
    disp(sprintf(' %15.4E %15.4E\n', X, F));
    f= @(x)8*exp(1-x)+7*log(x);
    %f= @(x) x*x;
    disp('Value of minimum X calculated by MATLAB function fminbnd and Value of function F at X =');
    a= fminbnd(f, 1,2);
    disp(sprintf(' %15.4E %15.4E\n', a, f(a)));
      
    function [F] = GETFUN (X)
       F= 8*exp(1-X)+7*log(X);
       %F= X*X;
    function [X, F, X1, X4, NFV] = GOLDIN(X1, X4, N, DLT)
      NFV = 0;
      TAU = 0.61803;
%     --- Determine Number of Iterations needed

	  N= ceil(log(DLT/2)/log(TAU));
%   ------ Intermediate point closest to Left starting point a0
      X2 = X1+ (1-TAU)*(abs(X4-X1));
      [F2] = GETFUN(X2);
      for I = 1 : N 
        X3 = X1+TAU*(abs(X4-X1));
        NFV=NFV+1;      
	    [F3] = GETFUN(X3);
	    if (F2 < F3)
          X4=X3;
          X3=X2;
          X2 = X1+ (1-TAU)*(abs(X4-X1));
          [F2] = GETFUN(X2);
          disp(sprintf(' Current Interval after Iteration %d is:', I ));
          disp(sprintf(' %15.4E %15.4E\n', X1, X4));
        else
	      X1 = X2;
	      X2 = X3;
	      F2 = F3;
          disp(sprintf(' Current Interval after Iteration %d is:', I ));
          disp(sprintf(' %15.4E %15.4E\n', X1, X4));
        end
	    C2 = abs(X4 - X1);
      end
      X = X2;
      F = F2;

