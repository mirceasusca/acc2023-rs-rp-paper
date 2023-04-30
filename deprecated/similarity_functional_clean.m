function S = similarity_functional_clean(G,K,x,method_G,method_K,W)

T = x(1);
Q = x(2);
Gd = c2d(G,T,method_G);

% discretization operator D(K,T)
Kd = c2d(K,T,method_K);

% quantization operator Q(Kd,Q)
[Kd,~,~,~] = quantize_tf(Kd,Q);

L = series(K,G);
% G0 = feedback(L,1);

Ld = series(Kd,Gd);
% G0d = feedback(Ld,1);

% lambda = 1e-5;
lambda = 0;
S = similarity_integral(L,Ld,W) + lambda*sum(1./x);
% is_stable = all(abs(eig(G0d)) < 1);

end