%% https://www.mathworks.com/help/control/ug/digital-servo-control-of-a-hard-disk-drive.html

load diskdemo
Gr = tf(1e6,[1 12.5 0],'outputdelay',1e-5);
Gf1 = tf(w1*[a1 b1*w1],[1 2*z1*w1 w1^2]); % first  resonance
Gf2 = tf(w2*[a2 b2*w2],[1 2*z2*w2 w2^2]); % second resonance
Gf3 = tf(w3*[a3 b3*w3],[1 2*z3*w3 w3^2]); % third  resonance
Gf4 = tf(w4*[a4 b4*w4],[1 2*z4*w4 w4^2]); % fourth resonance
G = Gr * (ss(Gf1) + Gf2 + Gf3 + Gf4);     % convert to state space for accuracy

cla reset
G.InputName = 'ic';
G.OutputName = 'PES';
h = bodeplot(G);
title('Bode diagram of the head assembly model');
setoptions(h,'Frequnits','Hz','XLimMode','manual','XLim', {[1 1e5]});

cla reset
Ts = 7e-5;
Gd = c2d(G,Ts);
h = bodeplot(G,'b',Gd,'r'); % compare with the continuous-time model
title('Continuous (blue) and discretized (red) HDA models');
setoptions(h,'Frequnits','Hz','XLimMode','manual','XLim', {[1 1e5]});

%% controller design
C = tf(1,[1 -1],Ts);
h = rlocusplot(Gd*C);
setoptions(h,'Grid','on','XLimMode','Manual','XLim',{[-1.5,1.5]},...
    'YLimMode','Manual','YLim',{[-1,1]});

C = C * zpk([.963,.963],-0.706,1,Ts);
h = rlocusplot(Gd*C);
setoptions(h,'Grid','on','XLimMode','Manual','XLim',{[-1.25,1.25]},...
    'YLimMode','Manual','YLim',{[-1.2,1.2]});

C1 = 50 * C;

cl_step = feedback(Gd,C1);
h = stepplot(cl_step);
title('Rejection of a step disturbance (PES = position error)')
setoptions(h,'Xlimmode','auto','Ylimmode','auto','Grid','off');

margin(Gd*C1)

diskdemo_aux1(1);

%% add notch filter
w0 = 4e3 * 2*pi;                                 % notch frequency in rad/sec
notch = tf([1 2*0.06*w0 w0^2],[1 2*w0 w0^2]);    % continuous-time notch
notchd = c2d(notch,Ts,'matched');                % discrete-time notch
C2 = C1 * notchd;

h = bodeplot(notchd);
title('Discrete-time notch filter');
setoptions(h,'FreqUnits','Hz','Grid','on');

C2 = 2 * C2;
margin(Gd * C2)

diskdemo_aux1(2);

cl_step1 = feedback(Gd,C1);
cl_step2 = feedback(Gd,C2);
stepplot(cl_step1,'r--',cl_step2,'b')
title('2nd-order compensator C1 (red) vs. 4th-order compensator C2 (blue)')

Gd = c2d(G,Ts);
Ts = 7e-5;

T = feedback(Gd*C2,1);
h = bodeplot(T);
title('Peak response of closed-loop sensitivity T(s)')

setoptions(h,'PhaseVisible','off','FreqUnits','Hz','Grid','on', ...
            'XLimMode','Manual','XLim',{[1e2 1e4]});

%% robustness analysis
[z2,w2,z3,w3] = ndgrid([.5*z2,1.5*z2],[.9*w2,1.1*w2],[.5*z3,1.5*z3],[.8*w3,1.2*w3]);
for j = 1:16,
    Gf21(:,:,j) = tf(w2(j)*[a2 b2*w2(j)] , [1 2*z2(j)*w2(j) w2(j)^2]);
    Gf31(:,:,j) = tf(w3(j)*[a3 b3*w3(j)] , [1 2*z3(j)*w3(j) w3(j)^2]);
end
G1 = Gr * (ss(Gf1) + Gf21 + Gf31 + Gf4);

Gd = c2d(G1,Ts);
h = bodeplot(Gd*C2);

title('Open-loop response - Monte Carlo analysis')
setoptions(h,'XLimMode','manual','XLim',{[8e2 8e3]},'YLimMode','auto',...
    'FreqUnits','Hz','MagUnits','dB','PhaseUnits','deg','Grid','on');

stepplot(feedback(Gd,C2))
title('Step disturbance rejection - Monte Carlo analysis')

%% continuous-time controller and plant
% Gc = G;  % process
% Cc = tf(1,[1 0]);

% C1 = 50*Cc*zpk([.963,.963],-0.706,1,Ts);
% C2c = 2 * C1 * notch
C2c = d2c(C2,'tustin')

%%
% bode(C2c,{1e0,1e7})

