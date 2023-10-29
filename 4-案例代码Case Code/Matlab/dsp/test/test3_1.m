% Zhou Zhiguo
% 2019.5.28
% 数字信号处理 参考答案
% 3-1
% Y =[1 -2  2  -3]
     
clear; 
close all;
clc;

X=[1 2 2 3];
x=ifft(X);
y1=cirshftt(x,2,4);
Y1=fft(y1);

y2 = circshift(x,2);  %循环右移2：u1=u((n-2));
%y2 = circshift(x,-2); %循环左移2：v1=u((n+2));
Y2=fft(y2);