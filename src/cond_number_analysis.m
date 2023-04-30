% % implementability (insensitive)
Tcenter = 0.000244205;
Qcenter = 2.44205e-05;

% % fidelity (sensitive)
% Tcenter = 4.273917245748884e-06;
% Qcenter = 1.024481125026998e-10;

x = [Tcenter,Qcenter];
% FI_HANDLE(x)
% C_HANDLE(x)
F = @(x) FUNC_LOG_BARRIER(FF_HANDLE,C_HANDLE,x);

dimF = 1;
dimX = 2;

% kappa = COND_NUMBER_NUM(F,dimF,x,dimX,h)

%%
NMC = 10;
% xv = zeros(NMC,dimX);
% cv = zeros(NMC,1);

C = Tcenter+Qcenter*1j;

% tol = 1e-6*3.2; % pragul in care se incadreaza toate pentru xi_1
tol = 1e-15/4; % pragul in care se incadreaza toate pentru xi_2
h = tol*x;
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

% clf
% figure(23), hold on
% PM = {};
% for k1 = 1:NT
%     disp(k1);
%     for k2 = 0:NQ-1
%         x = [Tv(k1),Qv(k2+1)];
%         [frequency,uppermu] = CON_FEASIBILITY_PLOT(x,params);
%         kappa = COND_NUMBER_NUM(F,dimF,x,dimX,h);
%         CV{k1*(k2+1)+k2} = {{kappa},{frequency},{uppermu}};
% %         semilogx(frequency,uppermu,'b')
%         Z(k2+1,k1) = kappa;
%     end
% end
PM = {};
figure(23)
for k1 = 1:NT
    disp(k1);
    for k2 = 1:NQ
%         x = [Tv(k1),Qv(k2)];
        Trand = Tcenter + (2*rand(1)-1)*h(1);
        Qrand = Qcenter + (2*rand(1)-1)*h(2);
        x = [Trand,Qrand];
        [frequency,uppermu] = CON_FEASIBILITY_PLOT(x,params);
        kappa = COND_NUMBER_NUM(F,dimF,x,dimX,h);
        semilogx(frequency,uppermu,'b'), hold on
        Z(k2,k1) = kappa;
    end
end
%
x_opt = [Tcenter,Qcenter];
[frequency,uppermu] = CON_FEASIBILITY_PLOT(x_opt,params);
kappa_center = COND_NUMBER_NUM(F,dimF,x_opt,dimX,h)
%
% figure(24)
% for idx=1:length(CV)
%     semilogx(CV{idx}{2}{1},CV{idx}{3}{1},'b'), hold on
% end
semilogx(frequency,uppermu,'r')
grid

% 
% for k=1:NMC
%     disp(k)
% %     z = sample_complex_ellipse(C,R);
% %     xv(k,:) = [real(z),imag(z)];
%     cv(k) = COND_NUMBER_NUM(F,dimF,xv(k,:),dimX,h);
% end

%
% figure
% contourf(Tv,Qv,db(Z))
% colorbar;
% scatter(xv(:,1),xv(:,2))
% surf(xv(:,1),xv(:,2),cv)
% plot3(xv(:,1),xv(:,2),cv,'-x')

%% Validation for ellipse generation (sampling)
% NMC = 1000;
% xv = zeros(NMC,dimX);
% 
% C = 0+60j;
% R = [64,4];
% 
% for k=1:NMC
%     xv(k,:) = sample_complex_ellipse(C,R);
% end
% 
% scatter(real(xv),imag(xv))
% % xlim([-R(1),R(1)])
% % ylim([-R(2),R(2)])
% % xlim([-100,100])
% % ylim([-100,100])
