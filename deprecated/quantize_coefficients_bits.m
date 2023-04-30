function [gq,nq,dq,Kq] = quantize_coefficients_bits(K,Ts,L,s)

Kd = c2d(K,Ts,'tustin');

[num,den] = tfdata(Kd,'v');
g = num(1);
num = num/g;
coefs = [num,den];
p = max(nextpow2(abs(coefs)));

f = L-s-p;
q = get_quantizer_step(f);

gq = q*round(g/q);
nq = q*round(num/q);
dq = q*round(den/q);

Kq = tf(gq*nq,dq,Kd.Ts);

end
