%%
% w = warning('query','last');
% id = w.identifier;
% warning('off',id);

%%
clearvars

%%
% load('CT_models_HDD.mat')
% Tmin = 1e-6;
% Tmax = 1e-5;
% Qmin = 1e-9;
% Qmax = 1e-6;
% wNapprox = 2*pi/Tmax*0.95;
% W = logspace(log10(wNapprox/1e4),log10(wNapprox),256);

load('CT_models_benchmark_ex1.mat')
Tcenter = 0.001;
Tmin = Tcenter/10;
Tmax = Tcenter*100;
Qmin = 1e-10;
Qmax = 1e-4;
wNapprox = 2*pi/Tmax*0.95;
W = logspace(log10(wNapprox/1e4),log10(wNapprox),256);

%%
metG = 'zoh';
metK = 'tustin';

% lambda = 1e-4;
lambda = 0.00;
margin = 0.00;
params = struct('G',G,'K',K,'metG',metG,'metK',metK,...
    'W',W,'lambda',lambda,'margin',margin);

F_HANDLE = @(x)similarity_functional_optim(x,params);
C_HANDLE = @(x)closed_loop_stable_nonlcon(x,params);
X0 = [Tmin,Qmin];

% 
Tvar = optimvar("T",LowerBound=Tmin,UpperBound=Tmax);
Qvar = optimvar("Q",LowerBound=Qmin,UpperBound=Qmax);
FUN_OPT = fcn2optimexpr(F_HANDLE,[Tvar,Qvar]);

x0.T = X0(1);
x0.Q = X0(2);

prob = optimproblem(Objective=FUN_OPT);
CON_OPT = fcn2optimexpr(C_HANDLE,[Tvar,Qvar]);
prob.Constraints.stability = CON_OPT <= 1;

% opts = optimoptions("fmincon",Display="iter-detailed");
% [sol,fval] = solve(prob,x0,Options=opts);

num_points = 200;
ms = GlobalSearch('Display','iter','NumStageOnePoints',num_points);
[sol,fval] = solve(prob,x0,ms);

%% plot results on a global scale
NP = 50;

% Tv = logspace(log10(Tmin),log10(Tmax),NP);
% Qv = logspace(log10(Qmin),log10(Qmax),NP);

Tv = linspace(Tmin,Tmax,NP);
Qv = linspace(Qmin,Qmax,NP);

[S,StabBin] = compute_T_Q_functional_grid(Tv,Qv,F_HANDLE,C_HANDLE);

%% functionality to test solution - time/frequency response, poles etc.
close all
plot_T_Q_functional(S,StabBin,Tv,Qv)

% X = [1e-5,1e-9];
% X = [2e-6,4.13636e-8];
X = [sol.T,sol.Q];
% X = [0.0206824,9.29648e-5];
% X = [0.097992,2.01015e-6]
% X = [8.64322e-06,9.8996e-7];
% X = 
% X = [2.87298e-6,2.37137e-7];
% X = Xopt;
% X = [7.49894e-6,5.62341e-7];
% X = X0;
plot(X(1),X(2),'+','LineWidth',4,'MarkerSize', 12,'color','r')
% X1 = [3.16226e-6,1.77828e-7];

analyze_solution(G,K,X(1),X(2),metG,metK,F_HANDLE,C_HANDLE)

