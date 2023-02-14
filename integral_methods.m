

function anti_der = integral_methods(a,b,h,method)
    %%This function estemates an integral 3 different ways.
    %Jacob Branson ME3060
    %This is under the hood stuff 
    %execute integral_script.m to see some action!
    %or call integral_methods(a,b,h,method) for custom estemation.

    way = method; %way of calculation
    r = a:h:b; %values for x
    n = length(r)-1; %index for sums
    syms y;
    f(y) = 200*sin(y)+5.5*y^3-8*y^2; %the function
    
    if strcmpi(way,'rectangle') == true
        for i = 1:n
            tmp(i) = f(r(i));
        end
        anti_der = h*double(sum(tmp));
        
    elseif strcmpi(way,'midpoint') == true
        for i = 1:n
            tmp(i) = f((r(i+1)+r(i))/2);
        end
        anti_der = h*double(sum(tmp));
        
    elseif strcmpi(way,'trapezoid') == true
        for i = 1:n
            tmp(i) = ((f(r(i)) + f(r(i+1)))/2) * (r(i+1)-r(i));
        end
        anti_der = double(sum(tmp));
        
    else 
        disp('ERROR: method not recognized!')
        
    end
    
end