function m = metrics(L,G0,Ld,G0d,Q)

% wB = bandwidth(G0);
% wBd = bandwidth(G0d);
% 
% m = abs(wB-wBd);

wB = 1e5;

% W = logspace(2,log10(wB),256);
W = linspace(1e2,wB,256);
% W = linspace(1e4,wB,256);

% M0 = freqresp(G0,W); M0 = abs(M0(:));
% M0d = freqresp(G0d,W); M0d = abs(M0d(:));

M0 = freqresp(L,W); M0 = abs(M0(:));
M0d = freqresp(Ld,W); M0d = abs(M0d(:));

% m = sum(abs(M0-M0d)) + sum(abs(diff(M0-M0d))) + ...
%     (1-all(abs(eig(G0d)) < 1))*1e4;

x1 = abs(M0-M0d);
% x2 = [1;abs(diff(M0-M0d))];
x2 = 1+[1;abs(diff(M0d))];
x3 = [1,(diff(W))]';
% m = mean(x1.*x2);

if all(abs(eig(G0d)) < 1)
    m = mean(x1.*x2.*x3);
else
    m = NaN;
end
% m = db(m);

if rand(1) < 0.05
    disp([Ld.Ts,Q,m])
end

% m = abs(xcorr(abs(M0),abs(M0d),0));

% m = sum(abs(abs(M0)-abs(M0d)))*(W(2)-W(1)) + (1-all(abs(eig(G0d)) < 1))*1e4;


% pd = sort(abs(pole(Kd)));
% pq = sort(abs(pole(Kq)));
% 
% zd = sort(abs(zero(Kd)));
% zq = sort(abs(zero(Kq)));
% 
% m = sum(abs(pd-pq))+sum(abs(zd-zq));

end