function [S,is_stable] = similarity_functional(G,K,T,Q,method_G,method_K,W,Gd,Kd)

% Gd = c2d(G,T,method_G);

% discretization operator D(K,T)
% Kd = c2d(K,T,method_K);
% 
% S = zeros(1,length(Q));

% for k = 1:length(Q)
% quantization operator Q(Kd,Q)
[Kd,~,~,~] = quantize_tf(Kd,Q);

L = series(K,G);
% G0 = feedback(L,1);

Ld = series(Kd,Gd);
G0d = feedback(Ld,1);

% S(k) = metrics(L,G0,Ld,G0d,Q(k));
% S(k) = similarity_integral(G0,G0d,W);


S = similarity_integral(L,Ld,W);
is_stable = all(abs(eig(G0d)) < 1);

end