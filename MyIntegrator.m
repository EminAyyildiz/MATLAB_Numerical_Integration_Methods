clc, clear;

random_number = [];
% We have created an empty matrix in which we will assign random number values to which we will create.
tol_value = logspace(-4,-1,20);
% We divide our tol value into 20 equal logarithmic intervals between 10^-4 and 10^-1 with the 'logspace' command.
estInt_value_adapSimp = [];
estInt_value_adapNonRec = [];
estInt_value_adapTrap =[];
% Here we define the matrices we assign as empty in order to get the estInt values of each function.
Adap_intervals_size = [];
Adap_NonRec_intervals_size = [];
AdapTrap_intervals_size = [];
% Here I have defined empty matrices to which I will assign the number of intervals of each function.
integral_value = [];
% Here I define the empty matrix to which I will assign the values of my MATLAB integral function, which I will later use to find the error values.
error_value_adapSimp = [];
nonrec_error_value=[];
adap_trap_error = [];
% I have defined the matrices where I will print the error value that is compared with the integral values of each function.
adapSimpson_time = [];
adap_nonRec_time = [];
adapTrap_time = [];
% I define empty matrices because I need to calculate the running times of each of my functions and put them in the matrix.
for num=1:100 % Here I created a for loop to run the random a and b value and integral values 100 times.
rng(num);%It allows us to control those numbers while generating random numbers.
randa = 1 +(5-1)*rand(1);% I choose a random number from 1-5.
randb = 5 +(9-5)*rand(1);% I choose a random b number between 5-9.
random_number = [randa randb;random_number];% I print my random a and random b to the matrix.
funcitons_integral_value = integral(@ayyildiz01,randa,randb);
% I call my MATLAB integral expression here.
integral_value(num) = funcitons_integral_value;
% I assign each integral value (it consists of 100) to my matrix that I defined at the beginning.
end
average_integral_value = mean(integral_value);
% Calculate the average of the integral values formed.
for i=1:20% Here I am looping it to run 20 times for my tol values.

tol = tol_value(i);%I discard the tol expression by calling that column from the matrix I created at the top of my code, at whatever value my variable (i) in my for loop is.
fprintf("tol value : %f \n",tol);% Prints the tol value to the command window.
for f =1 :100%I have defined my loop where I will run my functions 100 times.
rng(f);%It allows us to control those numbers while generating random numbers.
randa = 1 +(5-1)*rand(1);
randb = 5 +(9-5)*rand(1);
tic;
% We use the tic-toc command to calculate the runtime of the function.
[AdapestInt, ADAPintervals] = adapSimpsons(@ayyildiz01,randa,randb,tol);
adapSimpson_time(f,i) = toc;% Using the variables in my loops, I assign my toc value to my matrix, which I created at the beginning, every time the code block runs.
%Here, we call our adapSimpson file and calculate the random a and b values and the tol value and the estInt and intervals values in the function in the order determined in the first for loop.
estInt_value_adapSimp(f,i) = AdapestInt;
% I get the estInt values of the adap Simpson function and print it into my matrix.
tic;
[NRASestInt, NRASintervals] = adapSimpsonsNonRec(@ayyildiz01,randa,randb,tol);
%Here, we call our adapSimpsonNonRec file and calculate the random a and b values and the tol value and the estInt and intervals values in the function in the order determined in the first for loop.
adap_nonRec_time(f,i) = toc; %Using the variables in my loops, I assign my toc value to my matrix, which I created at the beginning, every time the code block runs.
% Here, we call our Adapsimpsonnonrec file and calculate the random a and b values and the tol value and the estInt and intervals values in the function in the order determined in the first for loop.
estInt_value_adapNonRec(f,i) = NRASestInt;
%I get the estInt values of the adapSimpsonNonRec function and print it into my matrix.
tic;
[ATRestInt, ATRintervals] = adapTrap(@ayyildiz01,randa,randb,tol);
% Here we call our adapTrap file and calculate the random a and b values and the estInt and intervals values in the function with the tol value in the order determined in the first for loop.
adapTrap_time(f,i) = toc;% Using the variables in my loops, I assign my toc value to my matrix, which I created at the beginning, every time the code block runs.
estInt_value_adapTrap(f,i) =ATRestInt;
% I get the estInt values of my adaptTrap function and print them into my matrix.
[ADAPprow,Adapcolumn] = size(ADAPintervals);
[NRASrow,NRAScolumn] = size(NRASintervals);
[ATRrow,ATRcolumn] = size(ATRintervals);
% Our goal here is to find how many rows and columns our intervals values, which we find as a result of the functions, consist of.
Adap_intervals_size(f,i)=ADAPprow;
Adap_NonRec_intervals_size(f,i) = NRASrow;
AdapTrap_intervals_size(f,i) = ATRrow;
%  I print the row values I found to my matrices that I created at the beginning, in rows and columns according to the variables I use in for loops.
end

end
Adap_intervals_size_average =mean(Adap_intervals_size);
Adap_NonRec_intervals_size_average = mean(Adap_NonRec_intervals_size);
AdapTrap_intervals_size_average = mean(AdapTrap_intervals_size);
% I calculated the average of the intervals number values that I printed on the matrix.
estInt_adapSim_average = mean(estInt_value_adapSimp);
estInt_adapNonRec_average = mean(estInt_value_adapNonRec);
estInt_adapTrap_average = mean(estInt_value_adapTrap);
% I calculated the average of my estInt values that I printed on the matrix.
adapSimp_time_average =mean(adapSimpson_time);
adapNonREc_time_aver = mean(adap_nonRec_time);
adapTrap_time_aver = mean(adapTrap_time);
%I averaged the values of the run times of each code I printed on the matrix.
for j=1:20

error_for_adapSimp = abs(((estInt_adapSim_average(j)-average_integral_value(1))/estInt_adapSim_average(j))*100);
error_value_adapSimp(j) = abs(error_for_adapSimp);
nonRec_error = abs(((estInt_adapNonRec_average(j)-average_integral_value(1))/estInt_adapNonRec_average(j))*100);
nonrec_error_value(j) =abs(nonRec_error);
error_trap =abs(((estInt_adapTrap_average(j)-average_integral_value(1))/estInt_adapTrap_average(j))*100);
adap_trap_error(j) = abs(error_trap);
% My general goal here is to find the average of the estInt values of each function and the error value with the average of my MATLAB integral value, and again, I print the matrices that I have defined on the top.
% I will use these expressions later when plotting.
end
figure(1);
hold on
plot(tol_value,Adap_intervals_size_average,'b',LineWidth=4,LineStyle=':');
hold on
plot(tol_value,AdapTrap_intervals_size_average,'black',LineWidth=2,LineStyle='--');
grid on
legend('adap size','adapttrap size');
% Here, while I take my tol values as x minus, I take my number of intervals as the y axis and use them in the graph.
figure(2);
hold on
plot(tol_value,adap_trap_error,'b',LineWidth=3,LineStyle='--');
hold on
plot(tol_value,error_value_adapSimp,'r',LineWidth=4,LineStyle='-.');
legend('adap trap error','error value adapSimp');
% I am creating a graph using the margin of error between the integral and function values I have found here as the y-axis and my tol value as the x-axis.
figure(3)
hold on
plot(tol_value,adapSimp_time_average,'r',LineWidth=3,LineStyle='-');
hold on 
plot(tol_value,adapNonREc_time_aver,'black',LineWidth=3,LineStyle=':');
hold on
plot(tol_value,adapTrap_time_aver,'green',LineWidth=2,LineStyle='--');
grid on
legend('AdapSim time', 'AdapNonRec time', 'AdapTrap time');
% Here I made my plot using the running times of each function on the y-axis and using my tol values on the x-axis.
save("results.mat");
% When the code runs with the save command, I save the data created in Workspace under the name "results.mat".