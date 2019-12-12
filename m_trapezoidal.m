function [A, y] = m_trapezoidal(x, nx, f, h)
    %y = polyval(f, x);
    
    p = 0;
    y(1) = f(x(1));

    for c=2: nx-1
        p = p + f(x(c));
        y(c) = f(x(c));
    end
    
    y(nx) = f(x(nx));

    A = (h/2) * (f(x(1)) + 2*p + f(x(nx))); 
    %y esta nh+1 que en realidad es una n es la de numeros de x por asi
    %decirlo, osea nx
end


