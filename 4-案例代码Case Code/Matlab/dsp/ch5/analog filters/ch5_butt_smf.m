% Zhou Zhiguo
% 2019.8.6
% Ch5 数字滤波器设计

% 巴特沃斯模拟滤波器幅度平方函数 极点位置
% Butterworth squared magnitude response function
% 课本P178 图5-24

clear; 
close all;
clc;

figure;
alpha = 0:0.01:2*pi;
x = cos(alpha);
y = sin(alpha);
plot(x,y,'--b');
hold on;

sys = tf([1],[-1 0 0 0 0 0 1]);
% sys = 
%     -1
%  -------
%  s^6 - 1
h = pzplot(sys,'r');

xlim([-1.2 1.2]);
ylim([-1.2 1.2]);
legend("N=3");