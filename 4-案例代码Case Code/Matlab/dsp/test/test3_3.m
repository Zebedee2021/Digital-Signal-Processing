% Zhou Zhiguo
% 2019.5.28
% 数字信号处理 参考答案
% 3-3

clear; 
close all;
clc;

X=[1 2 2 3];
x=ifft(X);
y=cirshftt(x,2,4);
Y=fft(y);

