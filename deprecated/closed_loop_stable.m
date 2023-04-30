function [c,ceq] = closed_loop_stable(G,K,x,method_G,method_K)

T = x(1);
Q = x(2);

Gd = c2d(G,T,method_G);

% discretization operator D(K,T)
Kd = c2d(K,T,method_K);

% quantization operator Q(Kd,Q)
[Kd,~,~,~] = quantize_tf(Kd,Q);

% L = series(K,G);
% G0 = feedback(L,1);

Ld = series(Kd,Gd);
G0d = feedback(Ld,1);

c = max(abs(pole(G0d)))-1;
ceq = [];

end