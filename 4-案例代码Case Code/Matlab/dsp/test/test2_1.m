% Zhou Zhiguo
% 2019.5.28
% 数字信号处理 参考答案
% 2-1
% Y =[1 -2  2  -3]
     
clear; 
close all;
clc;

u=[3 2 1 2 3];
v=[-2 1 0 1 1 1];
%3-1
u1=[3 3 2 1 2];%需要解决反转序号问题
%h = circshift(flip(u),3); %序列反转、循环右移3
h = circshift(u1,3); %序列反转、循环右移3
x = circshift(v,-1); %循环左移1;
%3-2
y_c = cconv(h,x,6);
y_l = conv(h,x);
%3-3
b = [2 1 2 3 3];
a = 1;
y = filter(b,a,x);

