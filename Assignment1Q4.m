close all; clear all;
disp('========================================');
disp('     GRADIENT by Finite Differences Assignment Q4     ');
disp('     AML 771: Design Optimization and Decision Theory   ');
disp('     Student: Debjit Hore       ');
disp('========================================');


A= GETMAT()
flag=0;
for i= 1:length(A)
    temp_A=(A(1:i,1:i)); %Sylvester Test %Principal minors are being truncated.
    if det(temp_A)<0 %Determinant of principal minor is being checked.
        flag=1;
    end
end

if flag==0
    disp('Positive Definite');
else
    disp('Not Positive Definite');
end

eig_A= eig(A)
if eig_A>0
    disp('All Eigen values are positive');
else
    disp('Atleast one Eigen Value is negative');
end
function [A]= GETMAT()
A11= 2;
A12=-1;
A13=0;
A21=A12;
A22=5;
A23=-2;
A31=A13;
A32=A23;
A33=3;
A=[A11 A12 A13; A21 A22 A23;A31 A32 A33];
end