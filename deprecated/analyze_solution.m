function analyze_solution(G,K,T,Q,method_G,method_K,FUN,NONLCON)

Gd = c2d(G,T,method_G);

% discretization operator D(K,T)
Kd = c2d(K,T,method_K);

% quantization operator Q(Kd,Q)
[Kdq,~,~,~] = quantize_tf(Kd,Q);

L = series(K,G);
G0 = feedback(L,1);

Ld = series(Kd,Gd);
G0d = feedback(Ld,1);

Ldq = series(Kdq,Gd);
G0dq = feedback(Ldq,1);

figure(1)
subplot(121)
bode(L,Ld,Ldq)
legend('L','Ld','Ldq');
%
subplot(122)
nyquist(L,Ld,Ldq)
legend('L','Ld','Ldq');

figure(2)
subplot(121)
bode(G0,G0d,G0dq)
legend('G0','G0d','G0dq');
%
subplot(122)
nyquist(G0,G0d,G0dq)
legend('G0','G0d','G0dq');

figure(3)
subplot(121)
bode(K,Kd,Kdq)
legend('K','Kd','Kdq');
%
subplot(122)
nyquist(K,Kd,Kdq)
legend('K','Kd','Kdq');

figure(4)
step(G0,G0d,G0dq)
legend('G0','G0d','G0dq');

FUN([T,Q])
NONLCON([T,Q])

end