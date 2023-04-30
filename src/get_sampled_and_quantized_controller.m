function Kdq = get_sampled_and_quantized_controller(K,T,Q,metK)

Kd = c2d(K,T,metK);

[A,B,C,D] = ssdata(Kd);

Aq = Q*round(A/Q);
Bq = Q*round(B/Q);

g = max([C(:);D(:)]);
C = C/g;
D = D/g;
Cq = Q*round(C/Q);
Dq = Q*round(D/Q);
gq = Q*round(g/Q);

Kdq = ss(Aq,Bq,gq*Cq,gq*Dq,T);

end