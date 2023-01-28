function [estInt, intervals] = adapSimpsonsNonRec(f, a, b,tol)

total=0; % Here I created the total variable that we will use at the end of our code.

cand_int = [a b]; % My aim in this line is the starting points of my candidate intervals that I will use in the function.

intervals = []; % In this line, I define an empty interval sequence so that I can add new intervals according to the expressions in the loops and reach the correct result.
intervals1 = []; %Here we define a new sequence of empty intervals where we will do the operations.
x = tol*2; % Here we assign the value of tol to the variable x.

while ~isempty(cand_int) % My aim here is to create a while loop.
% This loop will continue to run until my cand_int array, which I defined at the beginning, ~isempty, thanks to the isempty command I have used.
x =x/2; %Every time the loop returns, we divide our tol value by 2.
[m] = size(cand_int);%I calculated the number of rows and columns with the size command of our cand_int array that I defined here. 
cand_int2= []; % Here i define a new cand_int2 which is empty. Because I do the operations to be done in cand_int and transfer them to cand_int2.
% This code resets again every time a while returns. because my cand_int values have changed so I am printing the new values.
    for i = 1 : m %I created the for dingus here. Here, I want to assign the variable i and start from i=1 and increase 1 by 1, to progress to my m value, that is, to the value of the row number of my cand_int array that I defined at the beginning.
        lower= cand_int(i,1); %Here I find my new a value.
        % Every time my i value increases, I get the value in the 1st column of that i value.
        upper = cand_int(i,2); % Here I find my new b value.
        %Every time my i value increases, I get the value in the 2nd column of that i value.
        c = (lower+upper)/2;
        % Here I found the midpoint of the a and b values that I just found.
        % Since these statements are in a for loop every time my i statement changes
        % It will be calculated over and over again every time the code logs into the if block.

%       ((b-a)/6)*(f(a)+4*f((a+b)/2)+f(b));
        operation = ((upper-lower)/6)*(f(lower)+4*f((lower+upper)/2)+f(upper)) - ((c-lower)/6)*(f(lower)+4*f((lower+c)/2)+f(c)) - ((upper-c)/6)*(f(upper)+4*f((upper+c)/2)+f(c));
% In order to have a code in completely NonRec format with the operation variable, I am putting the operation that I defined in my intSimpson file before for my upper, lower and c values.
        if (x*15) >= abs(operation)
%Here i define my if condition. If the absolute value of my operation statement that I defined above is less than or equal to 15*X, this code block works. Also, this code is my stopping criteria. if my new intervals pass this condition, the intervals are imported into my array.
        intervals = [intervals ; lower c ; c upper];
        intervals1 = [intervals1; lower upper]; 
        %Actually both of the ıntervals arrays are same because in for loop we take mid point of the intervalas 1  
%Here I print my new a and b values that provide stooping ciretia to my intervals array, which I defined as an empty array at the beginning.

        else 
            
            cand_int2 = [cand_int2 ; lower c ; c upper];
% Here we make it pass to the else block when our if block is not provided. Our goal in this line is to take our new a, b and c values in cand_int and transfer them to cand_int2 by dividing them into a c, c b.
    
        end

    end
cand_int= cand_int2;
%Here I am transferring my cand?_int2 array, which I defined as empty at the beginning, to my original cand_int array, on which I did all the operations.
end
[eq]=size(intervals1);
%In this line, we calculate the number of rows and columns of our interval sequence, which we obtained in the if block, with a command.
for o = 1 : eq
%By assigning that variable with the new for loop we created, I made the sequence of intervals starting from 1 and formed in the if block to repeat as many as the number of lines.
t = intervals1(o,1);
y = intervals1(o,2);
%Here, I am calling the values in the row according to the variable o, as I did with cand_int before. In this way, I will perform the mathematical operation for each value in the interval sequence.
u = (t+y)/2;
%Here I determine my midpoint with the new values in the line determined by that value of my intervals.

% ((b-a)/6)*(f(a)+4*f((a+b)/2)+f(b))

total =  total + intSimpsons(@ayyildiz01,t,u)+intSimpsons(@ayyildiz01,u,y)+(intSimpsons(@ayyildiz01,t,u)+intSimpsons(@ayyildiz01,u,y)-intSimpsons(@ayyildiz01,t,y))/1/15;
% Here I write my total expression to find our estInt value.
% My total expression is the mathematical operation I did before according to Simpson rule.
% It's by computation for each value range. then we accumulate these results in the total variable.
end

estInt = total;

% Here I equate our estInt expression to the total expression we made above.