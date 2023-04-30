syms s a t T
L = ilaplace(1/s^2/(s+a))
Lnew = subs(L,t,t*T)
Z = ztrans(Lnew)