% Zhou Zhiguo
% 2019.4.23
% Ch5 数字滤波器设计
% 脉冲响应不变变换法---impinvar 

clear; 
close all;
clc;

%--------------------------------------------------------------------------
% https://ww2.mathworks.cn/help/signal/ref/impinvar.html
% Matlab demo

% Convert a sixth-order analog Butterworth lowpass filter to a digital filter using impulse invariance. 
% Specify a sample rate of 10 Hz and a cutoff frequency of 2 Hz. Display the frequency response of the filter.
%--------------------------------------------------------------------------
f = 2;
fs = 10;

[b,a] = butter(6,2*pi*f,'s');
[bz,az] = impinvar(b,a,fs);

freqz(bz,az,1024,fs);