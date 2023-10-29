%Zhou Zhiguo
%2019.4.21
%v1.0
% Classic IIR Filter Design
% https://ww2.mathworks.cn/help/dsp/examples/classic-iir-filter-design.html

clear; 
close all;
clc;

N = 8;
F3dB = .4;
d = fdesign.lowpass('N,F3dB',N,F3dB);
Hbutter = design(d,'butter','SystemObject',true);

Ap = .5;
setspecs(d,'N,F3dB,Ap',N,F3dB,Ap);
Hcheby1 = design(d,'cheby1','SystemObject',true);

hfvt = fvtool(Hbutter,Hcheby1,'Color','white');
axis([0 0.5 -5 0])
legend(hfvt,'Butterworth','Chebyshev Type I');

% Ast = 80;
% setspecs(d,'N,F3dB,Ast',N,F3dB,Ast);
% Hcheby2 = design(d,'cheby2','SystemObject',true);
% hfvt = fvtool(Hbutter,Hcheby2,'Color','white');
% axis([0 1 -90 2])
% legend(hfvt,'Butterworth','Chebyshev Type II');
% 
% setspecs(d,'N,F3dB,Ap,Ast',N,F3dB,Ap,Ast);
% Hellip = design(d,'ellip','SystemObject',true);
% hfvt = fvtool(Hbutter,Hcheby1,Hcheby2,Hellip,'Color','white');
% axis([0 1 -90 2])
% legend(hfvt, ...
%     'Butterworth','Chebyshev Type I','Chebyshev Type II','Elliptic');
% 
% axis([0 .44 -5 .1]);



