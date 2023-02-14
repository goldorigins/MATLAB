%% ME 3060 
%Jacob Branson
%This code solves the functions defined in fun_sto.m
%using given conditions.
clc,clear
syms x y
%this brings in the functions as f and g
[f,g] = fun_sto;


%giving initial conditions to functions
i_f1 = double(f(0,0));
i_f2 = double(g(0,0));
funs = [f(x,y)==i_f1,g(x,y)==i_f2];

%solve the equations
S = solve(funs,[x y]);

solutions = [double(S.x),double(S.y)]


