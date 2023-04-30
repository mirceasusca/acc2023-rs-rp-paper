function S = similarity_functional_optim(x,params)

% discrete-time plant Gd(z)
Gd = c2d(params.G,x(1),params.metG);

% discretization operator D(K,T)
Kd = c2d(params.K,x(1),params.metK);

% quantization operator Q(Kd,Q)
Kq = quantize_tf_optim(Kd,x(2));

L = series(params.K,params.G);
Ld = series(Kq,Gd);

S = similarity_integral(L,Ld,params.W) + params.lambda*sum(1./x);

end