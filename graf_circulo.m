function graf_circulo(fun, punto, dist)
    x = punto-dist:0.01:punto+dist;
    %para graficar todos los puntos del diametro
    y = arrayfun(fun, x);

    plot(abs(x), abs(y), '.', 'color', "r");
end