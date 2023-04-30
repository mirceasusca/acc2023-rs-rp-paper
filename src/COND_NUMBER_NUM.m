function kappa = COND_NUMBER_NUM(F,dimF,x,dimX,h)

JFx = JACOBIAN_FUNCTOR(F,dimF,x,dimX,h);

% relative condition number
kappa = norm(x)*norm(JFx)/abs(F(x));

end