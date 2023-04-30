function [S,StabBin] = compute_T_Q_SSV_grid(Tv,Qv,FUN)

NT = length(Tv);
NQ = length(Qv);

S = zeros(NQ,NT);
StabBin = zeros(NQ,NT);

parfor k1 = 1:NT
    disp(k1);
    for k2 = 1:NQ
        x = [Tv(k1),Qv(k2)];
        Sval = FUN(x);
        is_stable = Sval <= 1;
        S(k2,k1) = Sval;
        StabBin(k2,k1) = is_stable;
    end
end


end