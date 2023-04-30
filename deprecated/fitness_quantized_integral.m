function S = fitness_quantized_integral(Ts,K,L,s,wmin,Nw)

Kd = c2d(K,Ts,'tustin');

[gq,numq,denq,Kq] = quantize_coefficients_bits(K,Ts,L,s);

pd = sort(abs(pole(Kd)));
pq = sort(abs(pole(Kq)));

zd = sort(abs(zero(Kd)));
zq = sort(abs(zero(Kq)));

S = sum(abs(pd-pq))+sum(abs(zd-zq));

% wN = pi/Ts;
% wv = logspace(log10(wmin),log10(wN),Nw);
% 
% Hd = freqresp(Kd,wv);
% Hq = freqresp(Kq,wv);
% 
% Md = abs(Hd(:));
% Mq = abs(Hq(:));
% % Md = evalfr(Kd,exp(1j*wv*Ts));
% % Mq = evalfr(Kq,exp(1j*wv*Ts));
% 
% S = [0,diff(wv)]*abs(db(Md)-db(Mq));
% % S = sum(abs(db(Md)-db(Mq)));