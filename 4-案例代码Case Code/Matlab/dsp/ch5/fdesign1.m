% Zhou Zhiguo
% 2019.8.7
% Ch5 Êý×ÖÂË²¨Æ÷Éè¼Æ

% https://ww2.mathworks.cn/help/dsp/ref/fdesign.html?searchHighlight=fdesign&s_tid=doc_srchtitle

Fs = 96e3;
Fpass = 20e3;
Fstop = 24e3;
Apass = 0.01;
Astop = 80;

filtSpecs = fdesign.lowpass(Fpass,Fstop,Apass,Astop,Fs);
designmethods(filtSpecs);

lpFIR = design(filtSpecs,'equiripple','SystemObject',true);
lpIIR = design(filtSpecs,'ellip','SystemObject',true);

FIRmeas = measure(lpFIR);

IIRmeas = measure(lpIIR);

FIRcost = cost(lpFIR);

IIRcost = cost(lpIIR);

fvtool(lpFIR,lpIIR,'Fs',Fs);
legend('FIR Equiripple','Elliptic IIR');