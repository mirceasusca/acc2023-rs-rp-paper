Ts = 1e-3;

G0 = c2d(tf(1,[1 -1]),Ts,'zoh');
Wu = c2d(0.25*tf([1/2 1],[1/32 1]),Ts,'zoh'); 
InputUnc = ultidyn('InputUnc',[1 1]);
G = G0*(1+InputUnc*Wu);
Wp = c2d(makeweight(100,[1 0.5],0.25),Ts,'zoh');
bodemag(Wp)
G.InputName = 'u';
G.OutputName = 'y1';
Wp.InputName = 'y';
Wp.OutputName = 'e';
SumD = sumblk('y = y1 + d');

inputs = {'d','u'};
outputs = {'e','y'};
P = connect(G,Wp,SumD,inputs,outputs);

nmeas = 1;
ncont = 1;
[K,CLperf,info] = musyn(P,nmeas,ncont); 
bode(K)