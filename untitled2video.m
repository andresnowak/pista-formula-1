clear all;
clc;

%x = [100, 548, 1569, 2111, 2628, 1102, 2800];
%y = [1700, 866, 2379, 2995, 2161, 1426, 1200];



x = [300, 900, 2200, 2800];
y = [2300, -500, 2250, 200];

format long
p = polyfit(x, y, 3);

fp = @(x) p(1)*x.^3 + p(2)*x.^2 + p(3)*x + p(4);

%x1 = 100:5:2800;
%y1 = fp(x1);

x1 = 300:5:2800;
y1 = fp(x1);

dfp = @(x) ((3*p(1))*x.^2) + 2*p(2)*x + p(3);
fl = @(x) (1+(dfp(x).^2)).^(1/2);

n = 100;
%a = 100;
b = 2800;

%n = 100;
a = 300;
%b = 2800;

A = integral(fl, a, b);

fprintf("La longitud de curva es: %fm\n\n", A); 
%tiene que ser entre 5000 y 8000m

dfp2 = @(x) (6*p(1))*x + 2*p(2);

[rc100, xs, rc_derr] = menor_100(dfp, dfp2, 100, 2800, 10);

var_names = {'x', 'radio de curvatura'};
%xs = transpose(xs); es lo mismo que utilizar '
%rc100 = transpose(rc100); es lo mismo que utilizar '
T1 = table(xs', rc100', 'VariableNames', var_names);
disp(T1);

disp(length(xs));