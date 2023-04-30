WS = tf([0.6667,3],[1,0.03]);
WT = tf([1,50],[0.01,75]);
WR = tf(1,1);

T = ureal('T',0.02448,'Percentage',[-10,10]);
K = ureal('K',25.8017,'Percentage',[-10,10]);

G = tf(K,[T,1]);
% bode(G)

P = augw(G,WS,WR,WT);

nmeas = 1;
ncont = 1;
[K,CLperf,info] = musyn(P,nmeas,ncont); 
bode(K)

%%
L = series(K,G);
CL = feedback(L,1);

figure(1)
subplot(121)
bode(L)

subplot(122)
bode(CL)

figure(2)
step(CL)
