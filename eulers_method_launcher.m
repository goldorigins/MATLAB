% solves an ODE using Euler's method 
clc, clear

x0 = [0, 700];
h = 0.5;
tspan = [0 180];
[t,x] = eulode(@fun,tspan,x0,h);
yyaxis left
plot(t,x(:,1));
title('Spin Launch Trajectory Properties')
xlabel('Time (S)');
ylabel('Height (m)');
axis([0 180 0 26000])
yyaxis right
plot(t,x(:,2))
xlabel('Time (S)');
ylabel('Velocity (m/s)');
axis([-10 180 0 720])

function [t,x] = eulode(dxdt,tspan,y0,h)

    ti = tspan(1);tf = tspan(2);

    t = (ti:h:tf)'; n = length(t);
    if t(n)
        t(n+1) = tf;
        n = n+1;
    end
    x = ones(n,length(y0));
    x(1,:) = y0;
    for i = 1:n-1
    	x(i+1,:) = x(i,:) + dxdt(t(i),x(i,:))*(t(i+1)-t(i));
    end
end

function f = fun(t,x)
    g = 9.81; R = 6.37*10^6;
    f(1) = x(2);
    f(2) = -(g*R^2)/(R+x(1))^2;

end










