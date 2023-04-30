% implementability (insensitive)
Tcenter = 0.000244205;
Qcenter = 2.44205e-05;
x1 = [Tcenter,Qcenter];

% % fidelity (sensitive)
Tcenter = 4.273917245748884e-06;
Qcenter = 1.024481125026998e-10;
x2 = [Tcenter,Qcenter];

% x = [Tcenter,Qcenter];
% FI_HANDLE(x)
% C_HANDLE(x)
F = @(x) FUNC_LOG_BARRIER(FF_HANDLE,C_HANDLE,x);

dimF = 1;
dimX = 2;

NMC = 10; % NMC^2 experiments
tol = 1e-6*2.5;

figure(25)

%%
Tcenter = x1(1);
Qcenter = x1(2);

%
C = Tcenter+Qcenter*1j;

h = tol*[Tcenter,Qcenter];
LSB_T = h(1);
LSB_Q = h(2);
R = [LSB_T,LSB_Q];

Tmin = Tcenter-h(1);
Tmax = Tcenter+h(1);
Qmin = Qcenter-h(2);
Qmax = Qcenter+h(2);
Tv = linspace(Tmin,Tmax,NMC);
Qv = linspace(Qmin,Qmax,NMC);
NT = length(Tv);
NQ = length(Qv);
Z = zeros(NQ,NT);

subplot(121)
for k1 = 1:NT
    disp(k1);
    for k2 = 1:NQ
%         x = [Tv(k1),Qv(k2)];
        Trand = Tcenter + (2*rand(1)-1)*h(1);
        Qrand = Qcenter + (2*rand(1)-1)*h(2);
        x = [Trand,Qrand];
        [frequency,uppermu] = CON_FEASIBILITY_PLOT(x,params);
        kappa = COND_NUMBER_NUM(F,dimF,x,dimX,h);
        loglog(frequency,uppermu,'b'), hold on
        Z(k2,k1) = kappa;
    end
end
%
x_opt = [Tcenter,Qcenter];
[frequency,uppermu] = CON_FEASIBILITY_PLOT(x_opt,params);
% kappa_center = COND_NUMBER_NUM(F,dimF,x_opt,dimX,h)
% legend('Perturbed','Optimum')

%%
semilogx(frequency,uppermu,'r')
yline(1)
grid
xlabel('Frequency (rad/s)')
ylabel('$\mathbf{\mu\left(LLFT(\widetilde{P},\widetilde{K}_q)\right)\left(e^{j\omega\tau}\right)}$', 'Interpreter','latex')
title('\textbf{SSV frequency response for} $\xi_1^{\star}$','interpreter','latex')

%%
Tcenter = x2(1);
Qcenter = x2(2);

%
C = Tcenter+Qcenter*1j;

h = tol*[Tcenter,Qcenter];
LSB_T = h(1);
LSB_Q = h(2);
R = [LSB_T,LSB_Q];

Tmin = Tcenter-h(1);
Tmax = Tcenter+h(1);
Qmin = Qcenter-h(2);
Qmax = Qcenter+h(2);
Tv = linspace(Tmin,Tmax,NMC);
Qv = linspace(Qmin,Qmax,NMC);
NT = length(Tv);
NQ = length(Qv);
Z = zeros(NQ,NT);

subplot(122)
for k1 = 1:NT
    disp(k1);
    for k2 = 1:NQ
%         x = [Tv(k1),Qv(k2)];
        Trand = Tcenter + (2*rand(1)-1)*h(1);
        Qrand = Qcenter + (2*rand(1)-1)*h(2);
        x = [Trand,Qrand];
        [frequency,uppermu] = CON_FEASIBILITY_PLOT(x,params);
        kappa = COND_NUMBER_NUM(F,dimF,x,dimX,h);
        loglog(frequency,uppermu,'b'), hold on
        Z(k2,k1) = kappa;
    end
end
%
x_opt = [Tcenter,Qcenter];
[frequency,uppermu] = CON_FEASIBILITY_PLOT(x_opt,params);
kappa_center = COND_NUMBER_NUM(F,dimF,x_opt,dimX,h);

%%
semilogx(frequency,uppermu,'r')
yline(1)
grid
xlabel('Frequency (rad/s)')
ylabel('$\mathbf{\mu\left(LLFT(\widetilde{P},\widetilde{K}_q)\right)\left(e^{j\omega\tau}\right)}$', 'Interpreter','latex')
title('\textbf{SSV frequency response for} $\xi_2^{\star}$','interpreter','latex')
legend('Perturbed','Optimum')