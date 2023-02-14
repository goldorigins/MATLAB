%% FILE NAME: taylor_series_assignment2

%% CLASS: FALL ME 3060

%% DATE: Sept. 23, 2022

%% AUTHOR: Jacob Branson

%% PURPOSE: 
%  To perform a Taylor Series expansion on sin(x)

clc,clear
%% CODE
for n = 1:5
y = pi/3; %set evaluation point here (x)
 %set number of taylor terms here
a = pi; %set evaluation value here

divs = derivatives(n); %gets derivatives
f_of_a = f_a(divs,a); %passes derivatives and (a) to f_of_a gets f(a)
taylor_expansion = terms(f_of_a,n,a); %sends vars to make expansion

taylor_val = double(taylor_value(taylor_expansion,y)); %sends vars for value
taylor_val,n
error = (abs(sin(y)-taylor_val))/sin(y)*100;

    plot(n,error,'b*')
    hold on
    xlabel('n');
    ylabel('Error (%)');
    title('% Error for n Terms in Taylor Series Expansion');
end

function derivative = derivatives(n)
    %This function takes n for indexing and calculates derivatives of
    %sin(x) with order n
    n = (1:n);
    syms x; %symbolic place holder
    derivative(1,1) = sin(x);%initial function    
    for i = 1:length(n)
        derivative(i+1) = diff(sin(x),i); %calculates derivatives, stores
    end
end

function fun_at_a = f_a(divs,a)
    %This function calculates the function and its derivatives at (a)
    
    syms x;
    f(x) = divs;
    fun_at_a = f(a); %evaluates all functions at preset a
end

function taylor_expansion = terms(f_of_a,n,a)
    %This function creates terms for the taylor series
    
    n = (0:n);%makes n's for terms
    syms x;
    f_a = f_of_a;
    j = 1;
    for i = 1:length(n)

        if (f_a(i)/factorial(n(i))*1) == 0%checks for zero terms
            continue
        end
        frac(j) = (f_a(i)/factorial(n(i)));%makes fractional part
        poly(j) = (x-a)^n(i);%makes polynomial part
        j = j+1;
    end
    taylor_expansion = sum(frac.*poly); %generates taylor expansion
    
end

function taylor_val = taylor_value(taylor_expansion,y)
%This function plugs in values for solution

    syms x;
    f(x) = taylor_expansion;
    taylor_val = f(y);
    
end



