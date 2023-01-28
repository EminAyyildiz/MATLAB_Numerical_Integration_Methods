function [estInt, intervals] = adapTrap(f, a, b, tol)

% f is the function to be use.
% f = @ayyildiz01
% estInt estimated integral.
% intervals subintervals formed.
% a is the lowest point we use in the function.
% b is the top point we use in the function.
% tol is the error tolarance value.


c = (a+b)/2;% Our aim here is to determine our middle point. We determine the c point with the formula of determining the midpoint of two numbers, and we make our midpoint that we will use in our function.

estIntgen =intTrap(f,a,b);%We call our function in the a-b range from here

estInt1 = intTrap(f,a,c);%We call our function in the a-c range from here
estInt2 = intTrap(f,c,b);%We call our function in the c-b range from here



description = estIntgen-estInt1-estInt2; %where given in task |e(a, b) − e(a, c) − e(c, b)| We write the expression at the intervals we defined above.

if (7*tol) >= abs(description) %We write the operation we defined here in the if block. The reason we use the abs code is to get an absolute value expression.

% e(a, c) + e(c, b) + 71 (e(a, c) + e(c, b) − e(a, b))    
estInt = estInt1+ estInt2+ (estInt1+ estInt2-estIntgen)/7; %our goal here is to print the operation e(a, c) + e(c, b) + 1/7 (e(a, c) + e(c, b) − e(a, b)) given in task 1.

intervals = [a c; c b]; %at this point, the intervals we have defined are a-c; It is to convert it into a matrix in the c-b range.

else 
    
[est1, intervals1] = adapTrap(f, a, c, tol/2);

[est2, intervals2] = adapTrap(f, c, b, tol/2);

%Our goal in these two codes is to recalculate with half of the tolerance value according to the task given in the task when the operation in the else block is not performed.
%We call our a c, c b interval functions that we have defined separately before, and suppress the sub-numbers of each interval with intervals1 and intervals 2.
estInt = est1+est2;

intervals = [intervals1;intervals2];

end
