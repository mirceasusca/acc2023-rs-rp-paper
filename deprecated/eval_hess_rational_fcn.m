function [y,dy,ddy] = eval_hess_rational_fcn(beta,alpha,x)

b = polyval(beta,x);
a = polyval(alpha,x);

y = b./a;

[dn,dd] = polyder(beta,alpha);
dy = polyval(dn,x)./polyval(dd,x);

[ddn,ddd] = polyder(dn,dd);
ddy = polyval(ddn,x)./polyval(ddd,x);

end