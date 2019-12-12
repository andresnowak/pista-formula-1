function [rc100, xs, rc_derr] = menor_100(dfp, dfp2, a, b, h)
    rc = 0; %radio
    rc100(1) = 0; %lista de radios menor a 100
    count = 1;
    xs(1) = 0; %son los valores de x para la tabla

    for c=a:h:b
        rc = (abs(1 + dfp(c)^2)^3/2) / abs(dfp2(c));
        
        if rc <= 100
            if count == 1
                rc_derr = rc;
            end
            rc100(count) = rc;
            xs(count) = c;
            count = count + 1;
        end
    end
end