function J = FUN_FIDELITY(x,params)

T = x(1);
Q = x(2);

% tau = params.tau;
% alpha = params.alpha;
% k = params.k;
K = params.K;
% G = params.G;
metK = params.metK;
lambda = params.lambda;
W = params.W;

% Gd = get_nominal_discrete_plant_model(...
%     tau,alpha.NominalValue,k.NominalValue,T);
Kdq = get_sampled_and_quantized_controller(K,T,Q,metK);

% L = series(K,G);
% Ld = series(Kdq,Gd);

% J = similarity_integral_nyquist(L,Ld,W,lambda);
J = similarity_integral_nyquist(K,Kdq,W,lambda);

end