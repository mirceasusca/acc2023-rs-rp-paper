function [WS,WR,WT] = get_continuous_weighting_functions(...
    wB,M,A,wBT,MT,AT,MR)
% MR - maximum allowed command signal magnitude

WS = tf([1/M,wB],[1,wB*A]);
WT = tf([1,wBT],[AT,wBT*MT]);
WR = tf(1/MR,1);

end