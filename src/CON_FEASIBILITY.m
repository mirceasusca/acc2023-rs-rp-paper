function PeakMu = CON_FEASIBILITY(x,params)

T = x(1);
Q = x(2);

tau = params.tau;
alpha = params.alpha;
k = params.k;
K = params.K;
metG = params.metG;
metK = params.metK;
WS = params.WS;
WR = params.WR;
WT = params.WT;

Gd = get_uncertain_discrete_plant_model(tau,alpha,k,T);
Kd = get_sampled_and_quantized_controller(K,T,Q,metK);
[WSd,WRd,WTd] = get_discrete_weighting_functions(WS,WR,WT,T,metG);
Pd = augw(Gd,WSd,WRd,WTd);
PeakMu = compute_discrete_case_ssv(Pd,Kd);

end