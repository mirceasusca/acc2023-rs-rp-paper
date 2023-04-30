T1 = 4.273917245748884e-06; Q1 = 1.024481125026998e-10;
T2 = 0.000244205; Q2 = 2.44205e-05;

%%
L = series(K,G);
CL0 = feedback(L,1);

tau = params.tau;
alpha = params.alpha;
k = params.k;
K = params.K;
metG = params.metG;
metK = params.metK;
WS = params.WS;
WR = params.WR;
WT = params.WT;

%% (T1,Q1)
x = [T1,Q1];
T = x(1);
Q = x(2);

Gd11 = get_uncertain_discrete_plant_model(tau,alpha,k,T);   % numerical instability using transfer function!!
Gd1 = c2d(G.NominalValue,T,'zoh');
Kd1 = get_sampled_and_quantized_controller(K,T,Q,metK);
[WSd1,WRd1,WTd1] = get_discrete_weighting_functions(WS,WR,WT,T,metG);
Pd1 = augw(Gd1,WSd1,WRd1,WTd1);
% PeakMu1 = compute_discrete_case_ssv(Pd1,Kd1)

Ld1 = series(Kd1,Gd1);
CL0d1 = feedback(Ld1,1);

%% (T2,Q2)
x = [T2,Q2];
T = x(1);
Q = x(2);

Gd2 = get_uncertain_discrete_plant_model(tau,alpha,k,T);
Kd2 = get_sampled_and_quantized_controller(K,T,Q,metK);
[WSd2,WRd2,WTd2] = get_discrete_weighting_functions(WS,WR,WT,T,metG);
Pd2 = augw(Gd2,WSd2,WRd2,WTd2);
PeakMu2 = compute_discrete_case_ssv(Pd2,Kd2)

Ld2 = series(Kd2,Gd2);
CL0d2 = feedback(Ld2,1);

%%
close all

figure(1)
% bode(L,L,Ld2,{1e-4,1e6})
bode(L), hold on
w1 = logspace(-4,log10(pi/T1),200);
bode(L,w1)
w2 = logspace(-4,log10(pi/T2),200);
bode(Ld2,w2)
xline(pi/T2,'linewidth',2)
xline(pi/T1,'linewidth',2)
xlim([1e-4,1e6])
% bode(L,Ld1,Ld2)
legend('L','Ld1','Ld2')

%%
% bode(Ld1,Ld2)
% legend('Ld1','Ld2')

figure(2)
% bode(CL0,CL0d1,CL0d2)
bode(CL0,CL0,CL0d2)
legend('CL0','CL0d1','CL0d2')

% bode(CL0d1,CL0d2)
% legend('CL0d1','CL0d2')

%%
figure(3)
% step(CL0,CL0d1,CL0d2)
step(CL0,CL0,CL0d2,5)
hl2 = legend('CL0(s)','CL0(z), 123','CL0(z), 123');
set(hl2,'Interpreter','latex')

% step(CL0d1,CL0d2,10)
% legend('CL0d1','CL0d2')