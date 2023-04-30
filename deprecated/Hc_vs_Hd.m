b = K/T;
a = 1/T;
% b = 2;
% a = 5;

H = tf(b,[1,a]);

Ts = 1/50;
Hd = tf([b/a*(1-exp(-a*Ts)),0],[1,-exp(-a*Ts)],Ts);

step(H,Hd)