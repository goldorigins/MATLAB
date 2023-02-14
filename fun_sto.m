function [f,g] = fun_sto()
%%This function stores the functions f and g
syms f(x,y);
syms g(x,y);

%Input your functions here:
f(x,y) = 4-y-2*x^2;
g(x,y) = 8-y^2-4*x;

end
