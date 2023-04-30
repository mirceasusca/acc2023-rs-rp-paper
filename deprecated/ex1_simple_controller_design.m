alpha = 0.2;
G = tf([-alpha,1],[1,3,3,1]);

K = ss(C);
[A,B,C,D]=ssdata(K);
[num,den]=ss2tf(A,B,C,D);
K = tf(num,den);

bode(K*G)