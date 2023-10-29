% Zhou Zhiguo
% 2019.5.5
% ch5_fir_frequency1
% Frequency sampling-based FIR filter design 频率取样法
% PPT 例题 

clear; 
close all;
clc;
%--------------------------------------------------------------------------
% Design a 14th-order FIR Bandpass filter to attenuate the components of the signal 0.25~0.5. 
%--------------------------------------------------------------------------
ord = 14;
f = [0 0.25 0.25 0.5 0.5 1];
m = [0 0 1 1 0 0];
npt = 512;
lap = 50;
window=chebwin(15,30);  
b1 = fir2(ord,f,m,npt,lap,window);
fvtool(b1,1);
Hz = filt(b1,1);
Hk = fft(b1);


[h1,w] = freqz(b1,1);
plot(f,m,w/pi,abs(h1));
xlabel('\omega / \pi');
lgs = {'Ideal','fir2 default'};
legend(lgs);
grid on;





