
function xn = bisect(f,a,b,Nmax,tol)
%This function uses bisection method to approximate an 'x' in f(x) = 0.
%The function takes:
%   -Symfun 'f' you'd like to solve
%   -Left side of range for a guess 'a'
%   -Right side of range for a guess 'b'
%   -Number of iterations for approximation 'Nmax'
%   -Tolerance 'tol'
    fa = f(a);
    fb = f(b);
    if fa*fb > 0 
        disp('Error! f(a)*f(b) > 0. The root isnt in range of your guess!')
    elseif fa*fb == 0%case of root being at a or b = 0.
        
        if fa == 0 && fb == 0
            xn = [a,b];
        elseif fa == 0
            xn = a;
        else 
            xn = b;
        end
        
    else
        
        for n = 1:Nmax
           xn = .5*(a+b); %uses midpoint formula to find val between a,b
           fxn = f(xn); 
           
           if abs(fxn) < tol %if you come inside range tol return xn
               break
           end
           
           if fa*fxn < 0 %if f(a)*f(xn) is neg then new xn = b
               b = xn;
           else %if f(b)*f(xn) is neg then new xn = a
               a = xn;
           end
           if n == Nmax %if you reach Nmax before you get in range tol.
               xn =('Warning: not converged in Nmax');

           end
           
        end
    end
    
end