function[x2, y2, dist] = sacar_punto(fun, x1, y1, largo)
count = 0;
dist = 0; 
%la distancia que vamos a sacar que deberia ser igual al largo

x2 = x1;
y2 = y1;
%al principio son iguales

while ~(dist >= largo)
    x2 = x2 + count;
    y2 = fun(x2);
    dist = dist_puntos(x1, y1, x2, y2);
    
    count = count + 0.00000001; 
    %para ser los mas precisos posibles usamos un paso muy pequeño
end