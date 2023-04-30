function S = similarity_integral(L,Ld,W)

M = freqresp(L,W); M = M(:);
Md = freqresp(Ld,W); Md = Md(:);

% L_copy = L;
% L_copy.outputDelay = 0;
[num,den] = tfdata(L,'v');

% Fs = exp(s*log(10));
[Im,Jacob,Hess] = eval_G_tilde_derivatives(num,den,W);
% [Im,Jacob,Hess] = eval_hess_rational_fcn(num,den,s);
% Hess = Hess.*exp(2*s)+Jacob.*exp(s);

% [Im,Jacob,Hess] = eval_hess_rational_fcn(num,den,log10(1j*W));
% dw = W(2)-W(1);
% assert(all(abs(diff(diff(W)))<1e-5)) % => scaling by dw for the integral does not matter
% assert(all(diff(W)==0));
% s = sum(abs(M-Md).*(1+abs(Hess')));
S = sum( abs((M-Md) .* (Hess')) );

end