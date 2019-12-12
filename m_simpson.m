function[A] = m_simpson(f, a, b, n)
    h = (b - a) / n;
    
    x = a:h:b; 
    y = arrayfun(f, x);
    
    diff = b - a;
    a1 = sum(y(2:2:end-1));
    a2 = sum(y(3:2:end-2));

    A = diff * (f(x(1)) + 4 * a1 + 2 * a2 + f(x(end))) / (3 * n);  
end