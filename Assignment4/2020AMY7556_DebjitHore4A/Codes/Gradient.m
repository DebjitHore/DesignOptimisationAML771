function [GC] = Gradient(functionValue, X)
      N = max(size(X));              % N: Dimension of the space 
      epsilon = .001;
      F0= functionValue;
% ----- CENTRAL DIFFERENCE EVALUATION
      for I = 1: N
  	     A = X(I);
	     DX = epsilon;
	     if X(I) ~= 0.
	       DX = epsilon * abs(X(I));
	     end
	     X(I) = X(I) - .5 * DX;             %purturbing back
	     [F1] = getFunc (X);
	     X(I) = A;
	     X(I) = X(I) + .5 * DX;             %purturbing forward
	     [F] = getFunc (X);
	     X(I) = A;
	     GC(I) = (F - F1) / DX;
      end
 
      