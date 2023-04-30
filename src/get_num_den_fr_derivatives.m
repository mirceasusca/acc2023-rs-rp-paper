function Hess = get_num_den_fr_derivatives(b,a,w)
% function [Im,Jacob,Hess] = get_num_den_fr_derivatives(b,a,w)
% compute G_tilde(w) = beta(jw)/alpha(jw) and its first/second derivatives.

bp = polyder(b);
bpp = polyder(bp);
ap = polyder(a);
app = polyder(ap);

s = 1j*w;

bv = polyval(b,s);
bpv = polyval(bp,s);
bppv = polyval(bpp,s);
av = polyval(a,s);
apv = polyval(ap,s);
appv = polyval(app,s);

% Im = bv./av;
% Jacob = 1j*(bpv.*av-bv.*apv)./(av.^2);
% Hess = -((bppv.*av-bpv.*apv)./av.^2-(bpv.*apv+bv.*appv)./av.^2+2*bv.*apv.^2./av.^4); % ref
% Hess1 = -((bppv.*av-2*bpv.*apv-bv.*appv)./av.^2+2*bv.*apv.^2./av.^4);

% paper plots
% Hess = ((2*bpv.*apv+bv.*appv-bppv.*av)./av.^2-2*bv.*apv.^2./av.^4);

% correct
Hess = ((-2*bpv.*apv-bv.*appv+bppv.*av)./av.^2+2*bv.*apv.^2./av.^3);

end