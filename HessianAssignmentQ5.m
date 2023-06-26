function [] = Hessian()
clear all; close all;
disp('========================================');
disp('      HESSIAN BY FINITE DIFFERENCES Assignment1 Q5    ');
disp('      AML 771 Desgin Opimization and Decision Theory  ');
disp('      Student: Debjit Hore      ');
disp('========================================');

     N = 3; epsilon = 0.01;
%    ===== READ POINT
     X(1:N) = [1 2 3];             % Initial vector 
     [F] = GETFUN(X);  
     F0 = F;
     [H] = HESIAN(X);
%     ----- CENTRAL DIFFERNCE FOR DIAGONAL
%           FORWARD DIFF. FOR OFF DIAGONAL
     for I = 1: N
	   A1 = X(I);
	   D1 = epsilon;
	   if (X(I) ~= 0)
	     D1 = epsilon * abs(X(I));
       end
	   X(I) = X(I) - D1;
	   [F] = GETFUN(X);
	   F1 = F;
	   X(I) = A1;
	   X(I) = X(I) + D1;
	   [F] = GETFUN(X);
	   F2 = F;
	   X(I) = A1;
	   HA(I, I) = (F1 - 2 * F0 + F2) / (D1 * D1);
	   if (I < N)
	     for J = I + 1 : N
	       HA(I, J) = F0 - F2;
	       A2 = X(J);
	       D2 = epsilon;
	       if (X(J) ~= 0)
		     D2 = epsilon * abs(X(J));
           end
	       X(J) = X(J) + D2;
	       [F] = GETFUN(X);
	       HA(I, J) = HA(I, J) - F;
	       X(I) = X(I) + D1;
	       [F] = GETFUN(X);
	       HA(I, J) = HA(I, J) + F;
	       X(I) = A1;
	       X(J) = A2;
	       HA(I, J) = HA(I, J) / (D1 * D2);
	       HA(J, I) = HA(I, J);
         end
       end
     end
     disp('  ')
     disp('HESSIAN')
% ---PRINT RESULTS
     H     
     disp('APPROXIMATE HESSIAN')
     HA
     
     
     function [F] = GETFUN(X)
%    ===== DEFINE FUNCTION
     F = X(1)^3 * X(2) + X(2)^3 * X(3) + X(3)^2 * X(1)^2;
     F = 2*X(1)^2 + 5*X(2)^2 + 3*X(3)^2 -2*X(1)*X(2)-4*X(2)*X(3);

     function [H] = HESIAN(X)
%    ===== HESSIAN
     H(1, 1) = 4 ;
     H(1, 2) = -2;
     H(1, 3) = 0;
     H(2, 1) = -2;
     H(2, 2) = 10;
     H(2, 3) = -4;
     H(3, 1) = 0;
     H(3, 2) = -4;
     H(3, 3) = 6;
