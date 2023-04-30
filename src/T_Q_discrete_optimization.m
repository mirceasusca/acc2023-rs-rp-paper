%% 
% clearvars

%%
load('data/robust_controller_experiment_1.mat')
K = K7;
metG = 'zoh';
metK = 'tustin';

lambda = 1;

Tcenter = 0.001;
Tmin = Tcenter/10000;
Tmax = Tcenter;
Qmin = 1e-10;
Qmax = 1e-4;

% % implementability
% LSB_T = 0.00001e-4;
% LSB_Q = 0.00001e-5;
% Tcenter = 0.000244205;
% Qcenter = 2.44205e-05;
% interval = 4;

% % fidelity
% LSB_T = 1e-7;
% LSB_Q = 1e-12;
% Tcenter = 4.273917245748884e-06;
% Qcenter = 1.024481125026998e-10;
% interval = 4;
% 
% Tmin = Tcenter-interval*LSB_T;
% Tmax = Tcenter+interval*LSB_T;
% Qmin = Qcenter-interval*LSB_Q;
% Qmax = Qcenter+interval*LSB_Q;

% wNapprox = 2*pi/Tmax*0.95;
wNapprox = pi/Tmax*0.95;
% W = logspace(log10(wNapprox/1e4),log10(wNapprox),256);
W = linspace(wNapprox/1e4,wNapprox,256);

params = struct('G',G,'K',K,'metG',metG,'metK',metK,'lambda',lambda,'W',W,...
    'tau',tau,'alpha',alpha,'k',k,'WS',WS,'WR',WR,'WT',WT);

%%
X0 = [sqrt(Tmin*Tmax),sqrt(Qmin*Qmax)];

FI_HANDLE = @(x)FUN_IMPLEMENTABILITY(x,params);
FF_HANDLE = @(x)FUN_FIDELITY(x,params);
FSSV_HANDLE = @(x)CON_FEASIBILITY(x,params);
C_HANDLE = @(x)CON_FEASIBILITY(x,params);

Tvar = optimvar("T",LowerBound=Tmin,UpperBound=Tmax);
Qvar = optimvar("Q",LowerBound=Qmin,UpperBound=Qmax);
FUN_OPT = fcn2optimexpr(FF_HANDLE,[Tvar,Qvar]);
x0.T = X0(1);
x0.Q = X0(2);

prob = optimproblem(Objective=FUN_OPT);
CON_OPT = fcn2optimexpr(C_HANDLE,[Tvar,Qvar]);
prob.Constraints.stability = CON_OPT <= 1;

num_points = 10;
ms = GlobalSearch('Display','iter','NumStageOnePoints',num_points);
[sol,fval] = solve(prob,x0,ms);

%% plot results on a global scale
NP = 250;

% Tv = linspace(Tmin,Tmax,NP);
% Qv = linspace(Qmin,Qmax,NP);

Tv = logspace(log10(Tmin),log10(Tmax),NP);
Qv = logspace(log10(Qmin),log10(Qmax),NP);

% [S,StabBin] = compute_T_Q_functional_grid(Tv,Qv,FI_HANDLE,C_HANDLE);
[S,StabBin] = compute_T_Q_functional_grid(Tv,Qv,FF_HANDLE,@(x) 0);
% [S,StabBin] = compute_T_Q_SSV_grid(Tv,Qv,FSSV_HANDLE);

%
% close all
% onlyFeasible = true;
onlyFeasible = false;
plot_T_Q_functional(S,StabBin,Tv,Qv,onlyFeasible)
colorbar;

% X = [sol.T,sol.Q];

% T1 = 0.000268225; Q1 = 1.08357e-5; f1 = T1*Q1;

% T2 = 0.000244205; Q2 = 2.44205e-05; f2 = T2*Q2;  % best found implementability value
% X = [T2,Q2];
T1 = 4.273917245748884e-06; Q1 = 1.024481125026998e-10;
X = [T1,Q1];
plot(X(1),X(2),'+','LineWidth',4,'MarkerSize', 12,'color','r')
legend('Fidelity','Optimum')
% T2 = 4.273917245748884e-06;
% Q2 = 1.024481125026998e-10;
% X = [T2,Q2];
% plot(X(1),X(2),'x','LineWidth',4,'MarkerSize', 12,'color','r')

% X1 = [3.16226e-6,1.77828e-7];
% legend('SSV','Implementation optimum', 'Fidelity optimum')
% [J1,J2,CON] = check_sensitivity_weights(Pd,Kd,WSd,WRd,WTd)
