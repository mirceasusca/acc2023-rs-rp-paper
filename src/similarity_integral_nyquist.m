function J = similarity_integral_nyquist(G,Gd,W,lambda)

M = freqresp(G,W); M = M(:);
Md = freqresp(Gd,W); Md = Md(:);

[num,den] = tfdata(G,'v');

% [Im,Jacob,Hess] = get_num_den_fr_derivatives(num,den,W);
Hess = get_num_den_fr_derivatives(num,den,W);

J = sum( abs((M-Md) .* (1+lambda*abs(Hess'))) );

end