Ts = 1e-3;

metG = 'zoh';

WS = c2d(tf([0.6667,3],[1,0.03]),Ts,metG);
WT = c2d(tf([1,50],[0.01,75]),Ts,metG);
WR = c2d(tf(1,1),Ts,metG);

% T = ureal('T',0.02448,'Percentage',[-10,10]);
% K = ureal('K',25.8017,'Percentage',[-10,10]);

% G = c2d(tf(K.NominalValue,[T.NominalValue,1]),Ts,metG);

a1 = ureal('a1',0.96,'Percentage',[-1,1]);
b1 = ureal('b1',1.033,'Percentage',[-2,2]);

% bode(G)
G = tf(b1,[1,-a1],Ts);

P = augw(G,WS,WR,WT);

opts = musynOptions('Display','Off');
nmeas = 1;
ncont = 1;
[K,CLperf,info] = musyn(P,nmeas,ncont,opts); 
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
