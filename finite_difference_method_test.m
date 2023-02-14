clc,clear
% This is a test script for the file finite_difference_method.m
data = importdata();                    

df_num = difffunc(data(1,:),data(2,:)); % RETRIEVES NUMERICAL DERIVATIVES FROM DIFFFUNC

dtheda = @(x) cos(x)-0.02*x.*sin(x.^2);   % THE GIVEN EQUATION

hold on
plot(data(1,:),df_num)                  % PLOTS THE NUMERICAL DERIVEATIVE
plot(data(1,:),dtheda(data(1,:))...     % PLOTS THE ANALYTICAL DERIVEATIVE
    ,'linewidth',2)
%set this ^^ because numerical solution was noisy. 
title('Numerical and Anylitical Derivative of Angular Position')
xlabel('Time (s)')
ylabel('Angular Rate (rad)')
legend('Numerical','Analytical')






