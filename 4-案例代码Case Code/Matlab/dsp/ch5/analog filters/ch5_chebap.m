% Zhou Zhiguo
% 2019.4.22
% Ch5 数字滤波器设计
% cheb1ap 切比雪夫模拟原型滤波器
clear; 
close all;
clc;

%--------------------------------------------------------------------------
% https://ww2.mathworks.cn/help/signal/ref/cheb1ap.html
% Chebyshev Type I
%--------------------------------------------------------------------------
figure(1);
[z,p,k] = cheb1ap(6,3);       % Lowpass filter prototype
[num,den] = zp2tf(z,p,k);     % Convert to transfer function form
freqs(num,den)                % Frequency response of analog filter
title('Chebyshev Type I')

%--------------------------------------------------------------------------
% https://ww2.mathworks.cn/help/signal/ref/cheb2ap.html
% Chebyshev Type II
%--------------------------------------------------------------------------
figure(2);
[z,p,k] = cheb2ap(6,70);      % Lowpass filter prototype
[num,den] = zp2tf(z,p,k);     % Convert to transfer function form
freqs(num,den)                % Frequency response of analog filter
title('Chebyshev Type II')