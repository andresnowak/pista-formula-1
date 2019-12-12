clear all;
clc;

% i(100, 1700) f(2800, 1200)
x = [100, 548, 1569, 2111, 2628, 1102, 2800];
y = [1700, 866, 2379, 2995, 2161, 1426, 1200];

format long
p = polyfit(x, y, 3);

fp = @(x) p(1)*x.^3 + p(2)*x.^2 + p(3)*x + p(4);

x1 = 0:5:3000;
y1 = fp(x1);

error1 = ((fp(100)-1700) * 100) / 1700;
error2 = ((fp(2800)-1200) * 100) / 1200;
%tiene que ser menos o igual a 5%.
fprintf("Puntos iniciales:\nx = %f, y = %f, Error: %f\n", 100, fp(100), error1);   
%se pasa por 0.32 porciento, esta bien.
fprintf("x = %f, y = %f, Error: %f\n\n",  2800, fp(2800), error2); 
%se pasa por 4.34 porciento, esta bien.

plot(x1, y1); 
axis([100 3200 100 3200]);

hold on;
plot(100, 1700, ".", 2800, 1200, ".");

dfp = @(x) ((3*p(1))*x.^2) + 2*p(2)*x + p(3);
fl = @(x) (1+(dfp(x).^2)).^(1/2);

n = 100;
a = 100;
b = 2800;

A = m_simpson(fl, a, b, n);

fprintf("La longitud de curva es: %fm\n\n", A); 
%tiene que ser entre 5000 y 8000m

dfp2 = @(x) (6*p(1))*x + 2*p(2);

[rc100, xs, rc_derr] = menor_100(dfp, dfp2, 100, 2800, 10);

var_names = {'x', 'radio de curvatura'};
%xs = transpose(xs); es lo mismo que utilizar '
%rc100 = transpose(rc100); es lo mismo que utilizar '
T1 = table(xs', rc100', 'VariableNames', var_names);
disp(T1);

[rc100, xs, rc_derr1] = menor_100(dfp, dfp2, 550, 560, 0.05);

var_names = {'x', 'radio de curvatura'};
T1 = table(xs', rc100', 'VariableNames', var_names);
disp(T1);

[rc100, xs, rc_derr2] = menor_100(dfp, dfp2, 2070, 2080, 0.05);

var_names = {'x', 'radio de curvatura'};
T1 = table(xs', rc100', 'VariableNames', var_names);
disp(T1);

radio_c_1 = 553.25; %ubicacion x de radio
y_radio_c_1 = fp(radio_c_1); %ubicacion y de radio

fprintf("punto minimo de derrape:\nx = %f, y = %f, rc = %f\n", radio_c_1, y_radio_c_1, rc_derr1);

radio_c_2 = 2078.4; %ubicacion x de radio
y_radio_c_2 = fp(radio_c_2); %ubicacion y de radio

fprintf("punto maximo de derrape:\nx = %f, y = %f, rc = %f\n", radio_c_2, y_radio_c_2, rc_derr2);

plot(radio_c_1, y_radio_c_1, "o", radio_c_2, y_radio_c_2, "o"); %puntos de derrape

[valy1, valy2] = chicharronero(p);

fprintf("\nminimo:\nx = %f y = %f\n", valy1, fp(valy1));
fprintf("maximo:\nx = %f y = %f\n", valy2, fp(valy2));

plot(valy1, fp(valy1), ".", valy2, fp(valy2), "."); %puntos min y max

u_seco = 1.5; %valor de coeficiente de friccion de seco
u_humedo = 1.1; %valor teorico para el humedo
peralte = tan(deg2rad(5)); %5 grados

v_seco = 11.3 * (((rc_derr1 * u_seco +  peralte) / (1 - u_seco * peralte)) ^ (1/2)); %km/h
v_seco2 = 11.3 * (((rc_derr2 * u_seco +  peralte) / (1 - u_seco * peralte)) ^ (1/2)); %km/h

fprintf("\nEn seco:\nv1 = %fkm/h\nv2 = %fkm/h\n", v_seco, v_seco2);

v_humedo = 11.3 * (((rc_derr1 * u_humedo +  peralte) / (1 - u_humedo * peralte)) ^ (1/2)); %km/h
v_humedo2 = 11.3 * (((rc_derr2 * u_humedo +  peralte) / (1 - u_humedo * peralte)) ^ (1/2)); %km/h

fprintf("\nEn humedo:\nv1 = %fmkm/h\nv2 = %fkm/h\n", v_humedo, v_humedo2);

pendien1 = dfp(radio_c_1);
pendien2 = dfp(radio_c_2);

pendien1_inv = -1 / pendien1; %pendiente inversa
pendien2_inv = -1 / pendien2; %pendiente inversa

rec_tang1_norm = @(x) pendien1 * x + (pendien1 * -radio_c_1) + y_radio_c_1; %recta tangente
rec_tang2_norm = @(x) pendien2 * x + (pendien2 * -radio_c_2) + y_radio_c_2; %recta tangente

x_rec_tang_norm_vals = 0:1:3500; %valores para graficar
y_rec_tang1_norm = arrayfun(rec_tang1_norm, x_rec_tang_norm_vals);
y_rec_tang2_norm = arrayfun(rec_tang2_norm, x_rec_tang_norm_vals);

plot(x_rec_tang_norm_vals, y_rec_tang1_norm, x_rec_tang_norm_vals, y_rec_tang2_norm); 
%graficacion de las rectas tangentes

rec_tang1 = @(x) pendien1_inv * x + (pendien1_inv * -radio_c_1) + y_radio_c_1; %recta tangente inversa
rec_tang2 = @(x) pendien2_inv * x + (pendien2_inv * -radio_c_2) + y_radio_c_2; %recta tangente inversa

[h1, k1, dist1] = sacar_punto(rec_tang1, radio_c_1, y_radio_c_1, rc_derr1); %circulo ubicacion
[h2, k2, dist2] = sacar_punto(rec_tang2, radio_c_2, y_radio_c_2, rc_derr2); %ciculo ubicacion

plot(h1, k1, '.');
plot(h2, k2, '.');

fun_circ1_y = @(x) (rc_derr1^2 - (x - h1)^2)^(1/2) + k1;
fun_circ1_y_inv = @(x) -((rc_derr1^2 - (x - h1)^2)^(1/2)) + k1;

fun_circ2_y = @(x) (rc_derr2^2 - (x - h2)^2)^(1/2) + k2;
fun_circ2_y_inv = @(x) -((rc_derr2^2 - (x - h2)^2)^(1/2)) + k2;

graf_circulo(fun_circ1_y, h1, dist1);
graf_circulo(fun_circ1_y_inv, h1, dist1);

graf_circulo(fun_circ2_y, h2, dist2);
graf_circulo(fun_circ2_y_inv, h2, dist2);

rec_tang1_grad1 = @(x) pendien1 * x - (pendien1 * radio_c_1) + y_radio_c_1 - 35.3553; 
rec_tang2_grad2 = @(x) pendien2 * x - (pendien2 * radio_c_2) + y_radio_c_2 + 35.3553;
% restandole 35.3553 se obtiene la distancia de 25m a la recta tangente

[x_tang_grad, y_tang_grad1, dist_grad] = sacar_punto(rec_tang1_grad1, radio_c_1-60, rec_tang1_grad1(radio_c_1-60), 80); 
%la grada se pasa por 20m del punto de derrape, por eso el -60

x_tang_grads = radio_c_1-60:0.01:x_tang_grad;
y_tang_grad1_1 = arrayfun(rec_tang1_grad1, x_tang_grads);

%disp(dist_puntos(radio_c_1-60, y_tang_grad1_1(1), x_tang_grad, y_tang_grad1_1(end)))

[x_tang_grad2, y_tang_grad2, dist_grad2] = sacar_punto(rec_tang2_grad2, radio_c_2-60, rec_tang2_grad2(radio_c_2-60), 80);
%la grada se pasa por 20m del punto de derrape, por eso el -60

x_tang_grads2 = radio_c_2-60:0.01:x_tang_grad2;
y_tang_grad2_2 = arrayfun(rec_tang2_grad2, x_tang_grads2);

graf_grad(x_tang_grads, y_tang_grad1_1, -14.14213);
graf_grad(x_tang_grads2, y_tang_grad2_2, 14.14213);

fprintf("\nLas coordenadas de la primera grada son:\nx1 = %f, y1 = %f\nx2 = %f, y2 = %f\n",x_tang_grads(1), y_tang_grad1_1(1), x_tang_grads(end), y_tang_grad1_1(end));
fprintf("x3 = %f, y1 = %f\nx4 = %f, y2 = %f\n",x_tang_grads(1), y_tang_grad1_1(1)-14.14213, x_tang_grads(end), y_tang_grad1_1(end)-14.14213);


fprintf("Las coordenadas de la segunda grada son:\nx1 = %f, y1 = %f\nx2 = %f, y2 = %f\n",x_tang_grads2(1), y_tang_grad2_2(1), x_tang_grads2(end), y_tang_grad2_2(end));
fprintf("x3 = %f, y1 = %f\nx4 = %f, y2 = %f\n",x_tang_grads2(1), y_tang_grad2_2(1)+14.14213, x_tang_grads2(end), y_tang_grad2_2(end)+14.14213);

hold off;
