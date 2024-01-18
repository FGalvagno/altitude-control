pkg load control

m = tf([0.63], [1 6.85]);

a = tf([1],[2.12 0 0]);

ki = 500;
ku = 500;
FLA=m*a
FLC=ku*feedback(FLA,ki)

pzmap(FLA)

rlocus(FLA)

#Entrada del sistema
t = (0:0.01:10)';
step = 0.2*(t>=0);

FLC = ku*feedback(FLA,ku)
lsim(FLC, step, t)

c = tf([1 0],[1]);
ki*FLA*c
rlocus(ki*FLA*c)

#Entrada del sitema
t = (0:0.01:3)';
step = 0.2*(t>=0);

FLC = ku*feedback(FLA*c,ku)
lsim(FLC, step, t)

pzmap(FLA*c)

# Calculo de psita
psita = sqrt(1/((-(pi/log(0.03)))^2+1))

# Calculo de omega
omega = 3/(psita*0.4) 

# Punto de operación del sistema
op = -psita*omega + i*omega*sqrt(1-psita^2)

# Polos de la función de transferencia
p = pole(FLA)

# Calculamos el aporte un polo en 0
theta_1 = 180 - rad2deg(atan(abs(imag(op)/real(op))))

# Calculamos la deficiencia del ángulo
d_a = 180 - theta_1

# Calculamos la ubicación del polo del compensador
re_pol_c = real(op)-imag(op)/(tan(deg2rad(d_a))) 

# Ajustamos ganancia del compensador con RLOCUS
c2 = tf([1 abs(p(1))], [1 abs(re_pol_c)])
rlocus(FLA*c*c2) #k = 340.81

#Entrada del sitema
t = (0:0.01:3)';
step = 0.2*(t>=0);
k = 340.81;
FLC = ku*feedback(FLA*c*c2*(k/ku),ku)

lsim(FLC, step, t)

pzmap(FLA*c*c2*(k/ku))
