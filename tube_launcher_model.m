%% Lab 6 Tube launcher
% Models and plots the trajectory of a lil plastic ball launched from a tube.
% model is made from experementally determined values
clc,clear

h1 = [30.75,30.375,30.75,31.625,... % measured height
    30.375,31.75,31.5,32.25,32,31.75]; 
ruler_height = 21.00; % ruler height
h2 = (h1+ruler_height)./12; % total ball max heights measured converted ft
h= h2.*0.3048; %change to meters
n = 1:length(h); % index of launches
avg_h = mean(h); % average height
std_h = std(h); % standard deviation of heights
thed = 90; % launch angle in degrees
g = 9.81; % gravitational acceleration in ft/s^2


% Velocity of launch
v_o = (sqrt(2*g*avg_h))/sin(thed); % exit velocity in m/sec

%% Plots:
% Bar Graph
plot(n,h,'black*','linewidth',3)
hold on
grid on
% show average on graph
yline(avg_h,'b','linewidth',2)
% show -+ standard dev
yline(std_h+avg_h,'r','linewidth',1)
yline(avg_h-std_h,'r','linewidth',1)
% title and axis
legend('Height','Average','Standard Deviation')
title('Recorded Height of Launched Ball')
xlabel({'Launch Number','Figure 1'})
ylabel('Recorded Height [m]')