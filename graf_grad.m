function graf_grad(x, y, mov)
plot(x, y, x, y + mov, "color", "b"); %grafica el largo

plot([x(end), x(end)], [y(end), y(end)+mov], "color", "b");
plot([x(1), x(1)], [y(1), y(1)+mov], "color", "b")
%grafica el ancho
end