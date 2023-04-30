function Gd = get_uncertain_discrete_plant_model(tau,alpha,k,T)
% T: sampling rate
% NMC: number of Monte Carlo simulations

% bode(Gdnom,'*'), hold on
% figure, hold on

gamma = exp(-T/tau);
delta = T/tau*gamma;
lambda = 1/2*(T/tau)^2*gamma*(1+alpha/tau);

b0 = 0;
b1 = 1-gamma-lambda-delta;
b2 = 2*gamma^2+gamma*(-2-lambda+delta)+lambda+delta;
b3 = gamma*(-gamma^2+gamma+lambda-delta);
num = k*[b0,b1,b2,b3];
% den = poly([gamma,gamma,gamma]); % numerical instability for T very small
a0 = 1;
a1 = -3*gamma;
a2 = +3*gamma^2;
a3 = -gamma^3;
den = [a0,a1,a2,a3];

% Gd = tf(num,den,T,'variable','z^-1');
% Gd = tf(num,den,T);

% A = [0,1,0;
%     0,0,1;
%     -a3,-a2,-a1];
% A = [
%    0.999987178303062  -0.000012821678672  -0.000004273889846;
%    0.000004273889846   0.999999999972601  -0.000000000009133;
%    0.000000000009133   0.000004273917246   1.000000000000000;
%    ];
% B = [0;0;1];
% C = k*[b3,b2,b1];
% D = 0;
% Gd = ss(A,B,C,D,T);
% den = [1.000000000000000  -2.999987178275664   2.999974356606127  -0.999987178330463];
Gd = tf(num,den,T);


% for idx=1:NMC
%     if mod(idx,10)==0
%         disp(idx);
%     end
%     Tunc = 10^(2*rand(1)-1)*T;
%     [~,~,Gdnom] = get_nominal_discrete_plant_model(tauNom,alphaNom,kNom,Tunc);
%     %
%     tau = tauNom + (2*rand-1)*percentage_tau/100;
%     alpha = alphaNom + (2*rand-1)*percentage_alpha/100;
%     k = kNom + (2*rand-1)*percentage_k/100;
%     [~,~,Gdex] = get_nominal_discrete_plant_model(tau,alpha,k,Tunc);
% %     bodemag(1-Gdex/Gdnom,'b');
%     bodemag(Gdnom,'r')
%     bodemag(Gdex,'b')
% end
% 
% end

end