

function integral_script()
%%Jacob Branson ME3060
%Run this from the console it will give results
%Or go under the hood and change the function to whatever you want
%Remember to change in both files but thats all that needs done
%Making h<.01 will make this execute for awhile but it can be made smaller
%for better accuracy!.
clc,clear
f = @integral_methods;

%change params here
a = 0;
b = 6;
h = 0.25;

% integral estemations for different methods
rec = f(a,b,h,'rectangle');
mid = f(a,b,h,'midpoint');
trap = f(a,b,h,'trapezoid');

%analytical integral
fun = @(x) 200*sin(x)+5.5*x.^3-8*x.^2;
I = integral(fun,a,b);

%calculate error
err_rec = abs(rec-I)/I*100;
err_mid = abs(mid-I)/I*100;
err_trap = abs(trap-I)/I*100;

%show results
e_r = ['Rectangular Integral: ',num2str(rec),' |Error %: ',num2str(err_rec)];
e_m = ['Midpoint Integral:    ',num2str(mid),' |Error %: ',num2str(err_mid)];
e_t = ['Trapezoid Integral:   ',num2str(trap),' |Error %: ',num2str(err_trap)];
e_I = ['Analytical Integral:  ',num2str(I)];

disp(e_r)
disp(e_m)
disp(e_t)
disp(e_I)
end

