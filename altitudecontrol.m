pkg load control
#Funciones de transferencia "mecanica"
m = tf([0.63], [1 6.85])
a = tf([1],[2.12 0 0])
#Constantes del microcontrolador
ki = 500;
ku = 500;
#Funcion de transferencia del sistema
FLA=m*a
FLC=ku*feedback(FLA,ki)
#Función de lazo abierto tiene dos polos en el origen
pzmap(FLA)

#Vemos que el sistema es inestable

#Entrada del sistema
t = (0:0.01:10)';
step = 0.2*(t>=0);
FLC = ku*feedback(FLA,ku)
lsim(FLC, step, t)
#Verificamos inestabilidad para todo k
rlocus(FLA)

#Agregamos un zero para desplazar el lugar de raices hacia la izquierda
c = tf([1 1],[1]);
rlocus(FLA*c)
#Simulamos el sistema estable
#Entrada del sitema
t = (0:0.01:3)';
step = 0.2*(t>=0);

FLC = ku*feedback(FLA*c,ku)
lsim(FLC, step, t)

#Tenemos que lograr que se cumplan las especificaciones de diseño, por lo tanto
rlocusx(FLA*c)