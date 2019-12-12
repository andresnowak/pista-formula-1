function[long_arco] = longitud_arco(fxd, x_min, x_max)
    f_long_arco = @(x) (1+(fxd(x).^2)).^(1/2);

    long_arco = integral(f_long_arco, x_min, x_max);
end