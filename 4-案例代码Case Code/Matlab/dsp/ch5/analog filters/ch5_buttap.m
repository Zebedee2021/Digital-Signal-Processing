% Zhou Zhiguo
% 2019.8.6
% Ch5 数字滤波器设计
% buttap 巴特沃斯模拟原型滤波器（归一化）
% 说明：和表5-1对应

clear; 
close all;
clc;

%--------------------------------------------------------------------------
% https://ww2.mathworks.cn/help/signal/ref/buttap.html
%--------------------------------------------------------------------------
n = 6;
[z,p,k] = buttap(n);          % Butterworth filter prototype
[num,den] = zp2tf(z,p,k);     % Convert to transfer function form
freqs(num,den)                % Frequency response of analog filter

%n = 3;
%z = [];
%p = exp(sqrt(-1)*(pi*(1:2:2*n-1)/(2*n)+pi/2)).';
%k = real(prod(-p));