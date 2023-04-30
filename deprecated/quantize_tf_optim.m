function Kq = quantize_tf_optim(Kd,q)

[num,den] = tfdata(Kd,'v');
g = num(1);
num = num/g;

gq = q*round(g/q);
nq = q*round(num/q);
dq = q*round(den/q);

Kq = tf(gq*nq,dq,Kd.Ts);

end
