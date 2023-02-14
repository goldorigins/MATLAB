%% ME 3020
%Lab 6

%This code models and plots the flow of water from a cylindrical 
%tank over time. The data was experementally taken and hard coded in.
%Depth was measured every 2 seconds untill the tank drained.
%We didnt measure to h=0 because the flow out began to dribble.
%The maximum height is at t=0.
%The data doesnt fit exactly to an exponet because the accuracy of the 
%measuring device was only .1cm and we were using our eyes to collect data.
%Diameter of oriface = .47625 cm
%Diameter of tank cross section = 6.985 cm

%% Code:

%Areas:
a_o = pi*(.47625/2)^2;
a_t = pi*(6.985/2)^2;

%Experementally measured depths (cm)
h_exp = [40,38.1,36.4,34.7,33,31.5,30,28.4,26.8,25.3,24,22.6,21.2,19.9,...
    18.8,17.4,16.2,15.1,13.9,12.9,11.9,10.9,9.8,8.9,8.1,7.3,6.5,5.8,5,...
    4.4,3.8,3.2,2.6,2.1,1.7]; 
u = 100;
%Times for exp data
t_exp = 0;
for i = 2:length(h_exp)
 t_exp(i,1) = t_exp(i-1)+2; 
end

%Numerically derived derivatives
h_dot = difffunc(t_exp,h_exp);

%h_dot fit data taken from curve fitter
p1 = 0.01015;
p2 = -0.908;
h_dot = p1.*t_exp+p2;

%Flow calculation: Q(t)=a_t*h_dot
for i = 1:length(t_exp)
    q(i) = -a_t*h_dot(i);
end

%Theoretical equation
Q = 6.7341.*h_exp.^.4593;
%Plots:


%%
plot(t_exp,h_exp,'r*-','linewidth',2)
title('Depth of Water Draining From Cylindrical Tank')
xlabel('Time (s)')
ylabel('Depth (cm)')
%%
plot(h_exp,Q,'r*-','linewidth',2)
title('Flow of Water Draining From Cylindrical Tank')
xlabel('Depth (cm)')
ylabel('Flow (cm^3/s)')
%%

plot(t_exp,difffunc(t_exp,h_exp))
hold on
plot(t_exp,h_dot)
title('Velocity of Water Draining From Cylindrical Tank')
xlabel('Time (s)')
ylabel('Velocity (cm/s)')
legend('Experemental Derivative','Linear Fit')



%t1 = text(35,15,'\leftarrowHeight(cm)','FontSize',15,'Color','r');
%t2 = text(18,5,'Out Flow(cm^3/s)\uparrow','FontSize',15,'Color','b');









 









