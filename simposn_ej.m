f = input("Ingrese su funcion: ");

a = input("Ingrese su primer limite: ");
b = input("Ingrese su segundo limite: ");

n = input("Ingrese numero de iteraciones: ");

h = (b-a)/n;
x = a:h:b;
nx = length(x);
A = m_simpson(f, a, b, n);
A = m_trapezoidal(x, nx, f, h);
disp(A)