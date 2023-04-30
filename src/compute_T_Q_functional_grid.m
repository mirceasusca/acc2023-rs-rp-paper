function [S,FeasBin] = compute_T_Q_functional_grid(Tv,Qv,FUN,NONLCON)

NT = length(Tv);
NQ = length(Qv);

S = zeros(NQ,NT);
FeasBin = zeros(NQ,NT);

parfor k1 = 1:NT
    disp(k1);
    for k2 = 1:NQ
        x = [Tv(k1),Qv(k2)];
        Sval = FUN(x);
        is_feasible = NONLCON(x) <= 1;
        S(k2,k1) = Sval;
        FeasBin(k2,k1) = is_feasible;
    end
end


end