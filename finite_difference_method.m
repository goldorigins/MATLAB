% uses finite difference method to approimate a function differental
function df = finite_difference_method(x,y)
n = length(x);
df = zeros(n,1);

for i=1:n
    switch i
        case 1
            % use forward for the first point
            df(1) = (4*y(2)-y(3)-3*y(1))/(2*(x(2)-x(1)));

        case n
            % use backward for the last point
            df(n) = (y(n-2)-4*y(n-1)+3*y(n))/(2*(x(n)-x(n-1)));
            
        case n-1
            % use backward for the second to last point
            df(n-1) = (y(n-3)-4*y(n-2)+3*y(n-1))/(2*(x(n-1)-x(n-2)));
            
        case 2
            % use forward for the second point
            df(2) = (4*y(3)-y(4)-3*y(2))/(2*(x(3)-x(2)));

        otherwise
            % use central difference
            for u=3:n-2
                df(u) = (-y(u+2)+8*y(u+1)-8*y(u-1)+y(u-2))/(12*(x(u+1)-x(u)));
            end

    end
end

    
end
