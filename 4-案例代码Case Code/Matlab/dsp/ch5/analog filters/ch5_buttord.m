% Zhou Zhiguo
% 2019.4.22
% Ch5 数字滤波器设计

% buttord 巴特沃斯数字滤波器设计
clear; 
close all;
clc;

%--------------------------------------------------------------------------
%https://ww2.mathworks.cn/help/signal/ref/buttord.html?s_tid=doc_ta

%For data sampled at 1000 Hz, design a lowpass filter with no more than 3 dB of ripple
%in a passband from 0 to 40 Hz, and at least 60 dB of attenuation in the stopband. 
%Find the filter order and cutoff frequency.
%--------------------------------------------------------------------------
fs = 1000;  %Hz
fp = 40;    %Hz
fs = 150;   %Hz
Ap = 3;     %dB
As = 60;    %dB
%--------------------------------------------------------------------------
%数字指标
%Wp = 2*pi*fp/fs = pi*40/500  = 0.08*pi;
%Ws = 2*pi*fp/fs = pi*150/500 = 0.3*pi;

%--------------------------------------------------------------------------
%归一化
wp = 40/500;  % = 0.08
ws = 150/500; % = 0.3

[N,wc] = buttord(wp,ws,3,60);

[z,p,k] = butter(N,wc);
sos = zp2sos(z,p,k);

freqz(sos,512,1000);
title(sprintf('N = %d Butterworth Lowpass Filter',N));