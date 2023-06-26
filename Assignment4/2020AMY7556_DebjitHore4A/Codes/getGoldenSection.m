    function [alphak_Golden] = getGoldenSection(f, x0, machinePrecision)
    close all; 

    %Initial uncertainty range [A, B]
    %A = input('Left point of initial range,  a0: '); %Passed to function GOLDIN as X1
    %B = input('Right point of initial range, b0: '); %Passed to function GOLDIN as X2
    A= x0(1);
    B= x0(2);
    %DLT = input('  Give Final Interval Length DLT/ Final uncertainty range: ');
    DLT =machinePrecision;
    NR = 0;
    NS = NR + 1;
    [X, F, A, B, NFV] = GOLDIN(A, B, NS, DLT, f);
    alphak_Golden= X;
      

    function [X, F, X1, X4, NFV] = GOLDIN(X1, X4, N, DLT, f)
      NFV = 0;
      TAU = 0.61803;
%     --- Determine Number of Iterations needed

	  N= ceil(log(DLT/2)/log(TAU));
%   ------ Intermediate point closest to Left starting point a0
      X2 = X1+ (1-TAU)*(abs(X4-X1));
      NFV=NFV+1;
      %[F2] = GETFUN(X2);
      [F2]= double(subs(f, X2));
      for I = 1 : N-1 
	    %X3 = TAU * X4 + (1 - TAU) * X1;
        X3 = X1+TAU*(abs(X4-X1));
        NFV=NFV+1;      
	    [F3] = double(subs(f, X3));
	    if (F2 < F3)
          X4=X3;
          X3=X2;
          X2 = X1+ (1-TAU)*(abs(X4-X1));
          [F2] = double(subs(f, X2));;
        else
	      X1 = X2;
	      X2 = X3;
	      F2 = F3;
        end
	    C2 = abs(X4 - X1);
      end
      X = X2;
      F = F2;

