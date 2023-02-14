%% FILE NAME: Assignment1_Jbranson
%% ME 3060

%% AUTHOR:  Jacob Branson

%% PURPOSE: 
%  Models and plots the water level in a tank 
%  supplied with a sinusoidal flow in. 
%%          
%%  
%% ASSUMPTIONS: 
% The liquid has a depth described by (y).
% The surface area of the liquid in the tank (A) is constant.        
% The Vol. Flow Rate into the tank (Q) is constant.
% When t=0, the tank is half full and y=0.
clc, clear

%% Constants:

global A;   % Surface are of the liquid in the tank (m^2)
global Q;   % Rate that the liquid flows into the tank (m^3/day)
global t_i; % Initial condition of time (days) 'where to begin'
global t_f; % Final condition of time (days)   'where to end'
global dt;  % Timestep (days)                  'step between calculations'
global t;   % An array of times from beginning to end
A = 1400;
Q = 500;
t_i = 0;
t_f = 10;
dt = 0.1;
t = [t_i:dt:t_f];

%% Program Main:

analytical_depth = analytical_solution(A,Q,t); %calls analytical solution 
                                               %and provides vars.
                                               
numerical_depth = numerical_solution(Q,A,t);   %calls numerical solution

plot(t,analytical_depth,'r-o')  %%plots analytical solution against time
title('Depth of Liquid in Tank Modeled Analytically and Numerically')
xlabel('Time (days)')
ylabel('Liquid Depth (m)')
hold on
plot (t,numerical_depth,'b-*')
legend('Analytical Solution','Numerical Solution')

%% Analytical Analysis Function
function analytical_depth = analytical_solution(A,Q,t)
    % This Function calculates the depth of the liquid using 
    % the analytical equation.
    analytical_depth = ((3*Q)/A)*((t/2)-((1/4)*sin(2*t)))-(Q/A)*t;

end
%% Numerical Analysis Function
function numerical_depth = numerical_solution(Q,A,t)
    % This function calculates the depth of the liquid
    % using the numerical equation.
    
    numerical_depth = [0,length(t)]; % Generates an array of zeros
                                     % thats the length of the time array
                                     % to be filled by while loop.
    x = 1;
    while x < length(t) %this says that while index is less than the 
                        %length of time array.
                        
        numerical_depth(x+1) = (t(x+1)-t(x))*(3*Q/A*(sin(t(x)))^2-Q/A)...
            +numerical_depth(x);
        
        x = x+1; % increments the index to move forward 1 per iteration.
        
    end

end





