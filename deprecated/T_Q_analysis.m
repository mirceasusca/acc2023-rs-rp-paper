%%
w = warning('query','last');
id = w.identifier;
warning('off',id);

%%
clearvars
% load('CT_models_HDD.mat')
load('CT_models_benchmark_ex1.mat')

% Tmin = 1e-6;
% Tmax = 1e-5;
% Qmin = 1e-9;
% Qmax = 1e-6;

Tcenter = 0.001;
Tmin = Tcenter/10;
Tmax = Tcenter*100;
Qmin = 1e-10;
Qmax = 1e-4;

NP = 100;

% Tv = linspace(Tmin,Tmax,NP);
% Qv = linspace(Qmin,Qmax,NP);

% Tv = [Tmin,Tmax];
% Qv = [Qmin,Qmax];

Tv = logspace(log10(Tmin),log10(Tmax),NP);
Qv = logspace(log10(Qmin),log10(Qmax),NP);

% Q0 = 9.536743164062500e-07;
% Qv = linspace(0.9*Q0,1.1*Q0,5);

NT = length(Tv);
NQ = length(Qv);

S = zeros(NQ,NT);
StabBin = zeros(NQ,NT);

% bode(feedback(K*G,1)), hold on

wNapprox = 2*pi/Tmax*0.95;
% W = logspace(2,log10(wB),256);
W = linspace(wNapprox/1e2,wNapprox,4098);

for k1 = 1:NT
    disp(k1);
    Gd = c2d(G,Tv(k1),'zoh');
    Kd = c2d(K,Tv(k1),'tustin');

    for k2 = 1:NQ
        [Sval,is_stable] = similarity_functional(G,K,Tv(k1),Qv(k2),...
            'zoh','tustin',W,Gd,Kd);
        S(k2,k1) = Sval;
        StabBin(k2,k1) = is_stable;
    end
end

%%
% plot(S(1,:))
figure(100)
h = gca;
I = find(StabBin(:) == false);
Svector = S(:);
Sunstable_vec = Svector(I);
NormTerm = min(Sunstable_vec);
Saux = S;
Saux(~StabBin) = max(Saux(:));
contourf(Tv,Qv,db(Saux/NormTerm))
% surf(Tv,Qv,db(S))
colorbar
xlabel('Sampling rate T [s]')
ylabel('Quantization rate Q')
set(h,'xscale','log')
set(h,'yscale','log')
% set(h,'zscale','log')
% set(h,'ColorScale','log')

% - deduc clustere pe culori (cateva categorii, 0-20 db, 20-40 etc
% - arat comportamentele un bucla inchisa pentru acele categorii

%% functionality to test solution - time/frequency response, poles etc.

Tstar = 0.00316228;
Qstar = 5.62341e-8;

Tstar = 0.00177828;
Qstar = 1e-5;

Tstar = 0.0316228;
Qstar = 1.77828e-5;

analyze_solution(G,K,Tstar,Qstar,'zoh','tustin')

%%
% Tstar = 0.000009191836735;
% Qstar = 0.000009795938776;
% Gd = c2d(G,Tstar,'zoh');
% Kdstar = c2d(K,Tstar,'tustin');
% Kdstar = quantize_tf(Kdstar,Qstar);
% 
% L = K*G;
% Ld = Kdstar*Gd;
% 
% G0 = feedback(L,1);
% G0d = feedback(Ld,1);
% 
% % bode(L,Ld)
% % bode(G0,G0d)
% step(G0,G0d)

%%
% % beta = [1,0,-3,0,-1];
% % alpha = [1,4];
% beta = [1,2];
% alpha = [1,5];
% x = 1j*logspace(-2,4,100);
% H = @(s) polyval(beta,s)./polyval(alpha,s);
% H2 = @(s1) (log10(s1)+2)./(log10(s1)+5);
% H3 = @(s2) (exp(s2*log(10))+2)./(exp(s2*log(10))+5);
% figure
% semilogx(abs(x),db(abs(H(x)))), hold on
% y = exp(x*log(10));
% plot(abs(x),db(abs(H2(y)))),
% z = log10(x);
% plot(abs(x),db(abs(H3(z)))),
% % [y,dy,ddy] = eval_hess_rational_fcn(beta,alpha,x);
