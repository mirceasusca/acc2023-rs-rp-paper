function [G,tau,alpha,k] = get_uncertain_continuous_plant_model(...
    tauNom,percentage_tau, alphaNom, percentage_alpha, ...
    kNom, percentage_k)
% precondition: nominal + ranges for CT TF parameters
% result: CT TF model

% tau = ureal('tau',tauNom,'Percentage',percentage_tau);
tau = tauNom;
alpha = ureal('alpha',alphaNom,'Percentage',percentage_alpha);
k = ureal('k',kNom,'Percentage',percentage_k);

G = tf(k*[-alpha,1],[tau^3,3*tau^2,3*tau,1]);

end