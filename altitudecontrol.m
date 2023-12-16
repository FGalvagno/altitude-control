pkg load control

m = tf([0.63], [1 6.85])
a = tf([1],[2.12 0 0])
FLA=m*a
FLC=feedback(FLA,1)

c = tf([1 0],1)
rlocus(FLA*c)
