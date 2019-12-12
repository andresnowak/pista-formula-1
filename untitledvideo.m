x = [300, 900, 2200, 2800];
y = [2300, -500, 2250, 200];

format long
p = polyfit(x, y, 3);

fp = @(x) p(1)*x.^3 + p(2)*x.^2 + p(3)*x + p(4);

X = 300:5:2800;
Y = fp(X); %esto ya crea una lista de valores de x evaluados con la funcion que nos da y

plot(x, y, "or", X, Y, "b-");

dfp = @(x) ((3*p(1))*x.^2) + 2*p(2)*x + p(3);
fl = @(x) (1+(dfp(x).^2)).^(1/2);

n = 100;
a = 300;
b = 2800;

A = m_simpson(fl, a, b, n);

fprintf("La longitud de curva es: %fm\n\n", A); 