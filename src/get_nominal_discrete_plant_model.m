function [num,den,Gdcomp] = get_nominal_discrete_plant_model(...
    tau,alpha,k,T)

gamma = exp(-T/tau);
delta = T/tau*gamma;
lambda = 1/2*(T/tau)^2*gamma*(1+alpha/tau);

b0 = 0;
b1 = 1-gamma-lambda-delta;
b2 = 2*gamma^2+gamma*(-2-lambda+delta)+lambda+delta;
b3 = gamma*(-gamma^2+gamma+lambda-delta);
num = k*[b0,b1,b2,b3];
a0 = 1;
a1 = -3*gamma;
a2 = +3*gamma^2;
a3 = -gamma^3;
den = [a0,a1,a2,a3];

Gdcomp = tf(num,den,T,'variable','z^-1');

end