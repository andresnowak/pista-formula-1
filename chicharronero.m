function [valy_min, valy_max] = chicharronero(p)
    dp = polyder(p); %deriva la funcion
    
    vals = roots(dp); %saca las raices del polinomio
    valy_min = vals(2); %minimo el valor dos
    valy_max = vals(1); %maximo el valor uno
end

