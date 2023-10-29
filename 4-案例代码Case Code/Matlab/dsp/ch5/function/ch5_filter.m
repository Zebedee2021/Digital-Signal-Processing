% Zhou Zhiguo
% 2019.5.5
% ch5_filter
% 说明：采用filter函数，进行滤波处理

clear; 
close all;
clc;
%--------------------------------------------------------------------------
% https://ww2.mathworks.cn/help/matlab/ref/filter.html
%--------------------------------------------------------------------------
% demo1
% 创建一个由正弦曲线数据组成的 1×100 行向量，其中的正弦曲线被随机干扰所损坏。
figure(1);
t = linspace(-pi,pi,100);
rng default  %initialize random number generator
x = sin(t) + 0.25*rand(size(t));

% 移动平均值滤波器沿数据移动长度为  的窗口，并计算每个窗口中包含的数据的平均值。
% 以下差分方程定义向量  的移动平均值滤波器：
% y(n)=[x(n) + x(n-1) + x(n-2) + x(n-3) + x(n-(windowSize-1))]/windowSize
% 窗口大小为 5 时，计算有理传递函数的分子和分母系数。
windowSize = 5; 
b = (1/windowSize)*ones(1,windowSize);
a = 1;

% 求数据的移动平均值，并绘制其对原始数据的图。
y = filter(b,a,x);

plot(t,x);
hold on;
plot(t,y);
legend('Input Data','Filtered Data');
grid on;

% 问题？ 滤波就是卷积，但卷积出来y2是104，y是100？怎么解释
%h = [0.2 0.2 0.2 0.2 0.2];
%y2 = conv(x,h);
%--------------------------------------------------------------------------
% demo1
% 此示例使用以下有理传递函数对数据的矩阵进行滤波。
% H(z)=1/(1-0.2z^-1)

figure(2);

%创建一个由随机输入数据组成的 2×15 矩阵。
rng default  %initialize random number generator
x = rand(2,15);

%定义有理传递函数的分子和分母系数。
b = 1;
a = [1 -0.2];

%沿着 x 的第二维度应用传递函数并返回每行的一维数字滤波结果。绘制原始数据的第一行对已滤波数据的图。
y = filter(b,a,x,[],2);

t = 0:length(x)-1;  %index vector

plot(t,x(1,:))
hold on
plot(t,y(1,:))
legend('Input Data','Filtered Data')
title('First Row')

%绘制输入数据的第二行对已滤波数据的图。
figure(3);
plot(t,x(2,:))
hold on
plot(t,y(2,:))
legend('Input Data','Filtered Data')
title('Second Row')



