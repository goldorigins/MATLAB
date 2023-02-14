%% FILE NAME: fibonacci_numbers_assignment2

%% DATE: Sept. 23, 2022

%% AUTHOR: Jacob Branson

%% PURPOSE: 
%  To get the even numbers in a simple fibonacci sequence


%% CODE


function fib_num_evens = fibonacci_numbers_assignment2(n)
    %This function takes 1 number (n) and generates the Fibonacci 
    %numbers between 1 and n.
    i = 1;     %counter for evens
    j = 3;       %just a counter var starts at 3 to perserve initial vals
    idx = (1:1:n)'; %index between 1 and input n delta(1)
    fib_num = zeros(length(idx),1); %allocates array to store n values of
                                    %fibbonacci numbers
                                    
    fib_num(1,1) = 0; fib_num(2,1) = 1; %gives fib_num some starting condition
    
    while j<=length(idx)
        fib_num(j,1) = fib_num(j-1)+fib_num(j-2); %gets fib numbers
        j = j + 1; %counts j up by 1 per itteration
        
        if mod(fib_num(j-2,1),2)~=0 %checks for even 
            continue
        end
        fib_num_evens(i,1) = fib_num(j-2,1); %all even values
        i = i + 1;
    end
end


