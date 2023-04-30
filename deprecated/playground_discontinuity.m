clearvars
load('CT_models.mat')

L = K*G;
margin(L)

T = feedback(L,1);
bode(T)

step(T)

%%
Ts = 1e-6;
Gd = c2d(G,Ts,'zoh');
Kd = c2d(K,Ts,'tustin');

Ld = series(Kd,Gd);
Td = feedback(Ld,1);

% step(Td)
% bode(Ld)

[num,den] = tfdata(Kd,'v');
g = num(1);
num = num/g;
num
den
coefs = [num,den]
p = max(nextpow2(abs(coefs)));

L = 32;
s = 1;
f = L-s-p;
q = get_quantizer_step(f)

gq = q*round(g/q);
numq = q*round(num/q);
denq = q*round(den/q);

Kq = tf(gq*numq,denq,Ts);
bode(Kq,Kd)
legend('Quantized','Ideal')

%%
Tsv = linspace(1e-7,1e-4,1000);
% Tsv = 7e-5;
% Tsv = 1e-6:1e-6:7e-5;
N = length(Tsv);
dv = zeros(1,N);

L = 24;
s = 1;
wmin = 1e-6;
Nw = 500;

for k=1:N
    dv(k) = fitness_quantized_integral(Tsv(k),K,L,s,wmin,Nw);
end

plot(Tsv,db(dv),'*-')

%%
Ts1 = 0.000031080821739;
S1 = 4.903614180045508;

Ts2 = 0.000030866649433;
S2 = -56.273070419071303;

%%
[~,~,~,Kd1] = quantize_coefficients_bits(K,Ts1,L,s);
[~,~,~,Kd2] = quantize_coefficients_bits(K,Ts2,L,s);
bode(Kd1,Kd2)