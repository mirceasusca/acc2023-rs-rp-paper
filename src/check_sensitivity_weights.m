function [J1,J2,CON] = check_sensitivity_weights(Pd,Kd,WSd,WRd,WTd)
% check feasibility and (TODO) functional values for input pair (T,Q)

CL0d = lft(Pd,Kd);
CL0zSd = CL0d(1,1);
CL0zRd = CL0d(2,1);
CL0zTd = CL0d(3,1);
subplot(131)
bodemag(CL0zSd*1/WSd,1/WSd)
subplot(132)
bodemag(CL0zRd*1/WRd,1/WRd)
subplot(133)
bodemag(CL0zTd*1/WTd,1/WTd)

J1 = 0;
J2 = 0;
CON = 0;

end