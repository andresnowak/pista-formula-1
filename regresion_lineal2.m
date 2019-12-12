clear all;
clc;

x = [3.9298, 13.7298, 5.8898, 4.4198, 18.6298];
y = [1.5, 5.8, 2.4, 1.7, 6.9];

x_prom = mean(x); 
y_prom = mean(y);

num = dot(x-x_prom, y-y_prom);
denx = dot(x-x_prom, x-x_prom);
deny = dot(y-y_prom, y-y_prom);

b1 = num/denx; %a
b0 = y_prom-b1*x_prom; %b
r = num/(sqrt(denx)*sqrt(deny));

fprintf("b1 = %f\nb0 = %f\nr = %f\n", b1, b0, r);

scatter(x, y);
hold on;

zx = linspace(0, 20, 50);
zy = b1 * zx + b0;

plot(zx, zy);

hold off;

disp("normal vs. friccion cinetica");


%{
x * y' = multiplicacion de cada valor y la suma
%}
