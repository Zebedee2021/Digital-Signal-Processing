%Zhou Zhiguo
%2019.4.17
%v1.0
%ZF 
clear; 
close all;
clc;

%定义系统
b=[0 1 0.5];
a=[1 -1 0.5];

%收敛域绘制
figure(1)

theta = linspace(0,2*pi);
r = 0.5*sqrt(2).*ones(1,100);
polarplot(theta,r)
%polarplot(r);
title('$ROC$', 'Interpreter', 'LaTex');

%幅面绘制
r_=0.5*sqrt(2)+0.1:0.01:5;
%为了保证图形的正确样式稍微截取一小部分图形；
%（在0.5*sqrt(2)处图形是发散变形的）
phi_=0:0.01:2*pi;
[r, phi]=meshgrid(r_, phi_);

clear phi_;
z_=r.*exp(phi.*1i);
H=(z_+0.5)./(z_.^2-z_+0.5);
clear z_;

figure(2)
[x,y,z]=pol2cart(phi,r,abs(H));
surf(x,y,z);
shading flat;
%相面绘制（在幅面的基础上绘制）
figure(3);
[x,y,z]=pol2cart(phi,r,unwrap(angle(H)));
surf(x,y,z);
shading flat;
%%3D图形的导出依赖于Bill McDonald, 所写的surf2stl函数