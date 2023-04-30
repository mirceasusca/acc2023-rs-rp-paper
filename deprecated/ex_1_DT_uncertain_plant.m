% alpha = 0.2;
% G = tf([-alpha,1],[1,3,3,1]);
% 
% K = ss(C);
% [A,B,C,D]=ssdata(K);
% [num,den]=ss2tf(A,B,C,D);
% K = tf(num,den);
% 
% bode(K*G)

%%
% syms s alpha T1 z t T n
% % ilaplace(1/(s-1))     %           returns  exp(t)
% 
% % Z1 = ztrans(ilaplace(1/(s+1)^3))
% % Z2 = ztrans(ilaplace(1/s/(s+1)^3))
% 
% % Z = ztrans(ilaplace((-alpha*s+1)/(s*(s+1)^3)))
% IL = ilaplace(1/(s*(s+1)^3))
% ILnew = subs(IL,t,n*T)
% Z = ztrans(ILnew)
% % pretty(Z)

%%
syms s alpha tau t T n k G z

G = k*(1-alpha*s)/(tau*s+1)^3;
Gaux = k*(1-alpha*s)/(tau*s+1)^3/s
gtaux = ilaplace(Gaux)
gnTaux = subs(gtaux,t,n*T)
Zaux = ztrans(gnTaux)
% disp('')
clc
pretty(Zaux)