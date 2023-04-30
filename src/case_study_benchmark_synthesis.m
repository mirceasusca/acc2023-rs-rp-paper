%%
clearvars

tauNom = 1;
alphaNom = 0.1;
kNom = 2;

percentage_tau = 0;
percentage_alpha = 10;
percentage_k = 5;

[G,tau,alpha,k] = get_uncertain_continuous_plant_model(...
    tauNom,percentage_tau, alphaNom, percentage_alpha, ...
    kNom, percentage_k);

pole(G)
zero(G)
zpk(G)
bode(G)

%% CT controller synthesis
wB = 1.5;
M = 2;
A = 1e-2;
%
wBT = 10*wB;
MT = M;
AT = A;
%
MR = 1e5;

[WS,WR,WT] = get_continuous_weighting_functions(wB,M,A,wBT,MT,AT,MR);

P = augw(G,WS,WR,WT);

nmeas = 1;
ncont = 1;
[K,CLperf,info] = musyn(P,nmeas,ncont); 

%%
[Kred,NS,recOrd] = get_reduced_order_K(K,P,CLperf);

%%
% K6 = Kred(:,:,6);
K7 = Kred(:,:,7);
K = K7;
