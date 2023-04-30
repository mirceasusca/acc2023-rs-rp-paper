function [frequency,uppermu] = compute_discrete_case_ssv_plot_extension(Pd,Kd)
nY = 1;
nU = 1;
[P,BLK,BKnames] = musynData(Pd,nY,nU);
synBLK = BLK;
% synBLK = abs(BLK);
opt = musynOptions;
CL = lft(P,Kd);
Ts = Pd.Ts;
nf = pi/Ts;
FRANGE = [1e-8*nf,nf];
CLss = ss(CL);  % closed-loop system
OPTS = struct('Focus',FRANGE,'Negative',false,'Decades',false);
OMEGA = freqgrid({tzero(CLss)},{pole(CLss)},Ts,4,OPTS);
CLg = frd(CLss,OMEGA);
[uppermu,~,DGInfo] = mussvSmoothDG(CLg,synBLK,opt.FullDG);
% PeakMu = max(uppermu);
% PeakMuSmooth = max(DGInfo.ub);
frequency = DGInfo.Frequency;

end