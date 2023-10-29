% Zhou Zhiguo
% 2019.8.6
% Ch5 数字滤波器设计
% Chebyshev Type I filter 数字滤波器设计

clear; 
close all;
clc;

%--------------------------------------------------------------------------
% https://ww2.mathworks.cn/help/signal/ref/cheb2ord.html

% For data sampled at 1000 Hz, design a lowpass filter with less than 3 dB of ripple in the passband defined from 0 to 40 Hz, and at least 60 dB of attenuation in the stopband defined from 150 Hz to the Nyquist frequency.
%--------------------------------------------------------------------------
Wp = 40/500;
Ws = 150/500;
Rp = 3;
Rs = 60;
[n,Ws] = cheb2ord(Wp,Ws,Rp,Rs);

[b,a] = cheby2(n,Rs,Ws);
freqz(b,a,512,1000);
title('n = 4 Chebyshev Type II Lowpass Filter');