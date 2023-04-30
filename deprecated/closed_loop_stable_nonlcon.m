function y = closed_loop_stable_nonlcon(x,params)

% discrete-time plant Gd(z)
Gd = c2d(params.G,x(1),params.metG);

% discretization operator D(K,T)
Kd = c2d(params.K,x(1),params.metK);

% quantization operator Q(Kd,Q)
Kq = quantize_tf_optim(Kd,x(2));

Ld = series(Kq,Gd);
G0d = feedback(Ld,1);

y = max(abs(pole(G0d)))+params.margin;

end